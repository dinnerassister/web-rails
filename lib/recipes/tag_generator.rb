module Recipes
  class TagGenerator

    def after_commit(record)
      TagGenerator.create_file
    end

    def self.create_file
      File.open(FILE_PATH, 'w') { |f|
        tags = Tag.all.map{|t| {id: t.id, name: t.name}}
        f.print tags.uniq.to_s
      }
    end

    private
    FILE_PATH = "#{Rails.configuration.x.generated_file_location}tags.json"
  end
end