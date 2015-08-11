# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tag.delete_all
["Main dish","Vegan","Dessert","Breakfast","Vegetarian",
 "Side dish","Salad","Soup & Stew","Noodle","Pasta",
 "Meat","Pork","Beef","Chicken","Tofu","Grill","Meal"].each do | name |
    Tag.find_or_create_by(name: name)
 end

# require 'json'
# recipes = JSON.parse(File.read("#{Rails.root}/db/pwmf_vegan_recipes.json"))
# recipes.each {|r| Recipe.create(r.merge(user_id: 1))}
