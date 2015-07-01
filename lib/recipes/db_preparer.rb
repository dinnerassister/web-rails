module Recipes
  class DbPreparer
    def initialize(user_id, params)
      @user_id = user_id
      @params = params
    end

    def self.process(user_id, params)
      DbPreparer.new(user_id, params).prep
    end

    def prep
      params[:user_id] = user_id
      delete_blank(params[:ingredients_attributes], :name)
      prep_photos
      delete_blank(params[:tags_attributes], :name)
      params
    end

    private
    attr_reader :params, :user_id

    def delete_blank(items, required_value)
      if items
        items.delete_if {|k, v| v[required_value].blank? && !v[:id]}
        items.each do |index, value|
          value[:_destroy] = true if value[required_value].blank?
        end
      end
    end

    def prep_photos
      if params[:photos_attributes]
        params[:photos_attributes].each {|key, value| value[:user_id] = user_id}
      end
    end
  end
end