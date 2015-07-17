# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tag.delete_all

Tag.create(id: 1, name: "Main dish")
Tag.create(id: 2, name: "Vegan")
Tag.create(id: 3, name: "Dessert")
Tag.create(id: 4, name: "Breakfast")
Tag.create(id: 5, name: "Vegetarian")
Tag.create(id: 6, name: "Side dish")
Tag.create(id: 7, name: "Salad")
Tag.create(id: 8, name: "Soup & Stew")
Tag.create(id: 9, name: "Noodle")
Tag.create(id: 10, name: "Pasta")
Tag.create(id: 11, name: "Meat")
Tag.create(id: 12, name: "Pork")
Tag.create(id: 13, name: "Beef")
Tag.create(id: 14, name: "Chicken")
Tag.create(id: 15, name: "Tofu")
Tag.create(id: 16, name: "Grill")
Tag.create(id: 17, name: "Meal")

require 'json'
recipes = JSON.parse(File.read("#{Rails.root}/db/pwmf_vegan_recipes.json"))
recipes.each {|r| Recipe.create(r)}