require 'recipes/db_preparer'

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_tags, only: [:show, :edit, :new]
  before_action :authenticate_user!, except: [:show, :index]

  def index
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
    clean_param = recipe_params
      tags = clean_param.delete(:tags)
      add_to_meal_plan = clean_param.delete(:add_to_meal_plan)
    @recipe = Recipe.new(clean_param)

    respond_to do |format|
      if @recipe.save
        save_tags(tags)
        save_to_meal_plan(add_to_meal_plan)
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
      cleaned_params = recipe_params
      tags = cleaned_params.delete(:tags)
      add_to_meal_plan = cleaned_params.delete(:add_to_meal_plan)
      if @recipe.update(cleaned_params)
        save_tags(tags)
        save_to_meal_plan(add_to_meal_plan)
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
    def save_to_meal_plan(value)
      if value == "true"
        MealRecipe.add_recipe(current_user.id, @recipe.id)
      else
        MealRecipe.delete_recipes(current_user.id, [@recipe.id])
      end
    end

    def save_tags(tags)
      if tags
        tags = tags.map {|t| ActionController::Base.helpers.strip_tags(t.downcase)}
        tags = tags.delete_if {|t| t.blank? }
        tags = tags.uniq.map {|t| Tag.find_or_create_by(name: t)}
      else
        tags = []
      end

      @recipe.tags = tags
    end


    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_tags
      @tag_names = Tag.pluck(:name)
    end

    def recipe_params
      cleaned_params = params.require(:recipe).permit(:name, :directions, :prep_time, :cook_time, 
                                                      :source_url, :serving, :add_to_meal_plan,
                                                       photos_attributes: photo_params,
                                                       tags: [],
                                                       ingredients_attributes: [:name, :id])
      Recipes::DbPreparer.process(current_user.id, cleaned_params)
    end

    def photo_params
      [ :photo, :photo_content_type, :photo_file_name, :tempfile, 
        :photo_file_size, :photo_updated_at, :_destroy, :id]
    end
end
