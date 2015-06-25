require 'recipes/db_preparer'

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients = Array.new(10, Ingredient.new)
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      cleaned_params = params.require(:recipe).permit(:name, :directions, :prep_time, :cook_time, 
                                                      :source_url, :serving, 
                                                       photos_attributes: photo_params,
                                                       ingredients_attributes: [:name, :id])
      Recipes::DbPreparer.process(current_user.id, cleaned_params)
    end

    def photo_params
      [ :photo, :photo_content_type, :photo_file_name, :tempfile, 
        :photo_file_size, :photo_updated_at, :_destroy, :id]
    end
end
