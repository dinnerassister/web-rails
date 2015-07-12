"use strict";

var RecipeBinder = function (elements) {
  this.delete_elements = elements['delete_elements'];
  this.delete_field = elements['delete_photo_field'];
  this.ingredient_list = elements['ingredient_list'];
  this.add_ingredient = elements['add_ingredient'];
  this.ingredient_template = elements['ingredient_template'];
  this.focus_next = elements['focus_next'];
  this.tag_input = elements['tag_input'];
  this.tag_list = elements['tag_list'];
  this.tag_delete_fields = elements['tag_delete_fields'];
  this.tag_names = elements['tag_names'];
  this.tag_template = elements['tag_template'];
}

RecipeBinder.prototype.bindAddIngredient = function() {
  var binder = this;
  $(this.add_ingredient).click( function(e) {
    e.preventDefault();
    var ingredient_length = $(binder.ingredient_list + ' input').length;
    var template = $(binder.ingredient_template).html();
    Mustache.parse(template);

    for (var i = ingredient_length; i < ingredient_length + 5; i++) {
      var html = Mustache.render(template, {index: i});
      $(binder.ingredient_list).append(html);
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

RecipeBinder.prototype.bindTagInput = function() {
  var tags = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: this.tag_names
  });

  $(this.tag_input).typeahead(null, {
    name: 'recipe-tags',
    source: tags,
    minLength: 2,
    limit: 10
  });

  var binder = this;
  $(this.tag_input).bind('typeahead:select', function(ev, suggestion) {
    binder.addTag(suggestion);
  });

  $(this.tag_input).keypress(function(e) {
    if (e.which == 13) {
      e.preventDefault();
      binder.addTag($(this).val());
    }
  });
}

RecipeBinder.prototype.addTag = function(tag_name) {
  var item_length = $(this.tag_list+ ' li').length;
  var template = $(this.tag_template).html();
  Mustache.parse(template);
  var html = Mustache.render(template, {name: tag_name});
  
  $(this.tag_list).append(html);
  $(this.tag_input).val("");
  $('.twitter-typeahead .tt-menu').hide();
  this.bindTagDeletion();
}


RecipeBinder.prototype.bindTagDeletion = function() {
  $(this.tag_delete_fields).click(function(e) {
    e.preventDefault();
    var parent = $(this).parent();
    parent.remove();
  });
}

function bindRecipeEvents(elements) {
  var binder = new RecipeBinder(elements);
  binder.bindAddIngredient();
  binder.bindDeleteElement();
  binder.bindFocusNextOnEnter();
  binder.bindTagInput();
  binder.bindTagDeletion();
}
