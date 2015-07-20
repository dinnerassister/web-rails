namespace :recipes do
  desc "Load sample recipes"
  task :load => :environment do
    require 'json'
    recipes = JSON.parse(File.read("#{Rails.root}/db/pwmf_vegan_recipes.json"))
    recipes.each {|r| Recipe.create(r)}    
  end
end
