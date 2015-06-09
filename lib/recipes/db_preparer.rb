class DbPreparer
  def self.prep(params, user_id)
    params["user_id"] = user_id
    params["ingredients_attributes"].delete_if {|_, value| value["name"].empty? }
  end
end
