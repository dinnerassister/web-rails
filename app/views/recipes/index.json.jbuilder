json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :directions, :prep_time, :cook_time, :reviewed, :source_url, :serving, :created_by
  json.url recipe_url(recipe, format: :json)
end
