# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tag.delete_all

Tag.create(id: 1, name: "Vegetarian")
Tag.create(id: 2, name: "Vegan")
Tag.create(id: 3, name: "Dessert")
Tag.create(id: 4, name: "Breakfast")
Tag.create(id: 5, name: "Main dish")
Tag.create(id: 6, name: "Side dish")
Tag.create(id: , name: "Salad")
Tag.create(id: , name: "Soup & Stew")
Tag.create(id: , name: "Noodle")
Tag.create(id: , name: "Pasta")
Tag.create(id: , name: "Meat")
Tag.create(id: , name: "Pork")
Tag.create(id: , name: "Beef")
Tag.create(id: , name: "Chicken")
Tag.create(id: , name: "Tofu")
Tag.create(id: , name: "Grill")