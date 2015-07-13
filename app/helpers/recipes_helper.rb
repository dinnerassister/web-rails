module RecipesHelper
  def photo_count
    @recipe.photos.length
  end

  def editable?
    current_user && current_user.id == @recipe.user_id
  end
end
