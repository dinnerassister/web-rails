require 'rails_helper'
require 'helpers/file_helper'

RSpec.describe Tag do

  it "generate tag json file after create" do
    tag1 = Tag.create(name: "vegan")
    tag2 = Tag.create(name: "salad")
    tag3 = Tag.create(name: "green")

    tag_json = [{id: tag1.id, name: tag1.name},
                {id: tag2.id, name: tag2.name},
                {id: tag3.id, name: tag3.name}
                ].to_s

    expect(file).to eq(tag_json)
  end

  xit "name is unique" do
    name = "dessert"
    Tag.create(name: name)
    Tag.create(name: name)

    expect(Tag.count).to eq(1)
    expect(Tag.last.name).to eq(name)
  end

  def file
    File.read("#{Rails.configuration.x.generated_file_location}tags.json")
  end
end
