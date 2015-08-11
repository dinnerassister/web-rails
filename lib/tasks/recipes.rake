namespace :recipes do
  desc "Load sample recipes"
  task :load => :environment do
    require 'json'
    recipes = JSON.parse(File.read("#{Rails.root}/db/viet_vegan_recipes.json"))
    recipes.each {|r| Recipe.create(r)}
    recipes.each {|r| Recipe.create(r.merge(user_id: 1))}
    recipes = JSON.parse(File.read("#{Rails.root}/db/dung_recipes.json"))
    recipes.each {|r| Recipe.create(r)}
    recipes.each {|r| Recipe.create(r.merge(user_id: 1))}
  end
end
