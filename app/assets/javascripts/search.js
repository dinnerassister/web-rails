"use strict";

var UserRecipeListBinder = function (elements) {
  this.add_all_recipes = elements['add_all_recipes'];
  this.add_to_meal_list = elements['add_to_meal_list'];
}

UserRecipeListBinder.prototype.bindAddAllRecipes = function() {
  var binder = this;
  $(this.add_all_recipes).click(function() {
    var recipe_ids = binder.getRecipeIds();

    if ($(this).hasClass("selected")) {
      $(this).removeClass("selected");

      binder.submit('/maindish/recipes', 'DELETE', {recipe_ids: recipe_ids})
      $(binder.add_to_meal_list).each(function(index) {
        $(this).removeClass('selected');
      });

    } else {
      $(this).addClass("selected");
      binder.submit('/maindish/recipes', 'POST', {recipe_ids: recipe_ids});
      $(binder.add_to_meal_list).each(function(index) {
        $(this).addClass('selected');
      });
    }
  });
}

UserRecipeListBinder.prototype.bindIndividualRecipe = function() {
  var binder = this;
  $(this.add_to_meal_list).each(function(index) {
    $(this).click(function(e) {
      e.preventDefault();
      var recipe_id = $(this).data("recipe-id");

      if ($(this).hasClass("selected")) {
        $(this).removeClass('selected');
        binder.submit('/maindish/recipe/' + recipe_id, 'DELETE', {})
      } else {
        $(this).addClass('selected');
        $.post("/maindish/recipe/" + recipe_id);
      }
    });
  });
}

UserRecipeListBinder.prototype.getRecipeIds = function() {
  var getDataFunc = function() { return $(this).data("recipe-id");}
  return $(this.add_to_meal_list).map(getDataFunc).get();
}

UserRecipeListBinder.prototype.submit = function(url, method, data) {
  $.ajax({
    url: url,
    type: method,
    data: data
  });
}


function bindUserRecipeListEvents(elements) {
  var binder = new UserRecipeListBinder(elements);
  binder.bindAddAllRecipes();
  binder.bindIndividualRecipe();
}
