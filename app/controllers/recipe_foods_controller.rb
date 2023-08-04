class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /recipe_foods or /recipe_foods.json
  def index
    @recipe_foods = RecipeFood.all
  end

  # GET /recipe_foods/1 or /recipe_foods/1.json
  def show; end

  # GET /recipe_foods/new
  def new
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  # GET /recipe_foods/1/edit
  def edit; end

  # POST /recipe_foods or /recipe_foods.json
  def create
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @food_ids = RecipeFood.where(recipe_id: @recipe.id).map(&:food_id)

    if @food_ids.include?(recipe_food_params[:food_id].to_i)
      return redirect_to user_recipe_path(current_user, @recipe.id),
                         alert: 'Ingredient already exists in the recipe!'
    end

    @recipe_food = RecipeFood.new(recipe_food_params)

    @recipe_food.recipe_id = @recipe.id

    respond_to do |format|
      if @recipe_food.save
        format.html do
          redirect_to user_recipe_path(current_user, @recipe), notice: 'Recipe food was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
  def update
    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        format.html { redirect_to recipe_food_url(@recipe_food), notice: 'Recipe food was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    respond_to do |format|
      format.html do
        redirect_to user_recipe_path(current_user, @recipe_food.recipe.id),
                    notice: 'Recipe food was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def generate_shopping_list
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_food.includes(:food)

    @ingredients = @recipe_foods.map { |rf| rf.food.name }

    respond_to do |format|
      format.html # Render a template (e.g., generate_shopping_list.html.erb)
      format.json { render json: @ingredients }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
