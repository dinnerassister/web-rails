require 'recipes/tag_generator'

FileUtils::mkdir_p Rails.configuration.x.generated_file_location

Recipes::TagGenerator.create_file