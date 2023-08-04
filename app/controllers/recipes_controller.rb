class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @user = current_user
    @recipes = Recipe.includes(:user).where(user_id: params[:user_id])
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.includes(:user).find_by(user_id: params[:user_id], id: params[:id])

    if @recipe.nil?
      redirect_to user_recipes_path(current_user), alert: 'Recipe not found.'
      return
    end

    @user = @recipe.user

    if @recipe.public || (@user == current_user)
      @recipe_food = RecipeFood.new
    else
      redirect_to new_user_recipe_recipe_food(@user, @recipe), alert: 'Sorry! This is a private recipe'
    end

    @recipe_foods = RecipeFood.includes(:recipe).where(recipe_id: @recipe.id)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @user = current_user
    @recipe.user_id = @user.id

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to user_recipe_path(@user, @recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_recipes_path(current_user), notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_shopping_list
    redirect_to shopping_list_path(params[:recipe_id])
  end

  def generate
    @quantity = []
    @foods = []
    @recipe_food = RecipeFood.where(recipe_id: params[:recipe_id])
    @recipe_food.each do |rf|
      found = false
      check_recipe_food = Food.find(rf.food_id)
      next if found

      @quantity << [rf.quantity, check_recipe_food.price]
      @foods << check_recipe_food.name
    end
    @total = 0
    @quantity.each do |q|
      @total += q[0] * q[1]
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
