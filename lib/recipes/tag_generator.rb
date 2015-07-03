module Recipes
  class TagGenerator

    def after_commit(record)
      File.open(FILE_PATH, 'w') { |f|
        tags = Tag.all.map{|t| {id: t.id, name: t.name}}
        f.print tags.to_s
      }
    end

    private
    FILE_PATH = "#{Rails.configuration.x.generated_file_location}tags.json"
  end
end