"use strict";

var RecipeBinder = function (elements) {
  this.delete_elements = elements['delete_elements'];
  this.delete_field = elements['delete_photo_field'];
  this.ingredient_list = elements['ingredient_list'];
  this.add_ingredient = elements['add_ingredient'];
  this.focus_next = elements['focus_next'];
}

RecipeBinder.prototype.bindAddIngredient = function() {
  var binder = this;
  $(this.add_ingredient).click( function(e) {
      e.preventDefault();
      var ingredient_length = $(binder.ingredient_list + ' input').length;

      for (var i = ingredient_length; i < ingredient_length + 5; i++) {
        var input = '<input type="text" autocomplete=off '
                  + 'name="recipe[ingredients_attributes][{{index}}][name]" '
                  + 'id="recipe_ingredients_attributes_{{index}}_name">';
        
        var index_input = input.replace(/{{index}}/g, i);
        $(binder.ingredient_list).append(index_input);
      }

      binder.bindFocusNextOnEnter();
  });
}

 RecipeBinder.prototype.bindFocusNextOnEnter = function() {
    $(this.focus_next).keypress(function (e) {
      var key = e.which;
      if (key == 13) {
        e.preventDefault();
        $(this).next().focus();
      }
    });
  }

RecipeBinder.prototype.bindDeleteElement = function() {
  var binder = this;
  $(this.delete_elements).click(function(e) {
    e.preventDefault();
    var parent = $(this).parent();
    parent.css("display", "none");
    parent.find(binder.delete_field).first().val("true");
  });
}

function bindRecipeEvents(elements) {
  var binder = new RecipeBinder(elements);
  binder.bindAddIngredient();
  binder.bindDeleteElement();
  binder.bindFocusNextOnEnter();
}
