class UserFactory
  def self.create(fields = {})
    User.create(user_fields.merge(fields))
  end

  def self.create_with_omniauth(fields = {})
    with_omni_fields = user_fields
    with_omni_fields[:uid] = "111"
    with_omni_fields[:provider] = "facebook"
    User.create(with_omni_fields.merge(fields))
  end

  def self.user_fields
    { name: "Homer",
      password: "BeerAndDonuts",
      email: "homer#{DateTime.now}@evergreen.com"}
  end
end
