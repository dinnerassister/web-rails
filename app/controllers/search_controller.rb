class SearchController < ApplicationController

  def tags
    @recipes = Recipe.with_tag(params[:name])
    render 'list'
  end

  def all
    @recipes = Recipe.all
  end
end