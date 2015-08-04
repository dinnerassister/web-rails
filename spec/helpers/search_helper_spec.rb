require 'rails_helper'

RSpec.describe SearchHelper do
  include SearchHelper

  context "shorten" do
    it "doesn't do anything when input is less than 40 char" do
      value = "something short"
      expect(shorten(value)).to eq value
    end

    it "shorten the word if input is more than 40 chars " do
      value = "There is nothing better than a friend, unless it is a friend with chocolate."
      expect(shorten(value)).to eq (value[0,37] + "...")
    end
  end
end
