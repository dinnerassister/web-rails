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
        save_tags
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
        save_tags
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
    def save_tags
      tags = params[:tags]
      
      if tags
        tags = params[:tags].uniq
        tags = tags.map {|t| ActionController::Base.helpers.strip_tags(t)}
        tags = tags.delete_if {|t| t.blank? }
        tags = tags.map {|t| Tag.find_or_create_by(name: t.capitalize)}
      else
        tags = []
      end

      @recipe.tags = tags
    end


    def set_recipe
      @recipe = Recipe.find(params[:id])
      @tag_names = Tag.pluck(:name)
    end

    def recipe_params
      cleaned_params = params.require(:recipe).permit(:name, :directions, :prep_time, :cook_time, 
                                                      :source_url, :serving, 
                                                       photos_attributes: photo_params,
                                                       tags_attributes: [:name, :id],
                                                       ingredients_attributes: [:name, :id])
      Recipes::DbPreparer.process(current_user.id, cleaned_params)
    end

    def photo_params
      [ :photo, :photo_content_type, :photo_file_name, :tempfile, 
        :photo_file_size, :photo_updated_at, :_destroy, :id]
    end
end
