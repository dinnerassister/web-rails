require 'rails_helper'

RSpec.feature 'Authentication' do

  scenario 'mannual sign up' do
    email = "Homer@evergreen.com"
    password = "BeerAndDonuts"
    name = "Homer"

    sign_up(name, email, password)
    visit  new_user_session_path

    fill_in "user_email", with: email
    fill_in "user_password", with: password

    click_button "Log in"
    expect(page).to have_content(name)
  end

  def sign_up(name, email, password)
    visit  new_user_registration_path
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_button "Sign up"

    click_link "Log out"
  end

  describe "twitter" do
    scenario 'sign up' do
      info = {name: "Lisa"}
      uid = mock_auth(:twitter, info)

      visit  new_user_registration_path
      click_link 'twitter_sign_in'
      
      user = User.where(uid: uid, provider: :twitter).first
      expect(user.name).to eq(info[:name])
    end

    scenario 'log in' do
      provider = :twitter
      uid = mock_auth(provider, {name: "Lisa"})
      user = UserFactory.create_with_omniauth(uid: uid, provider: provider)

      visit  new_user_session_path
      click_link 'twitter_sign_in'
      
      user_count = User.where(uid: uid, provider: provider).count
      expect(user_count).to eq(1)
    end
  end

  describe "google" do
    scenario 'sign up' do
      info = {first_name: "Bart", email: "bart@evergreen.com"}
      uid = mock_auth(:google_oauth2, info)

      visit  new_user_registration_path
      click_link 'google_sign_in'

      user = User.where(uid: uid, provider: :google_oauth2).first
      expect(user.name).to eq(info[:first_name])
      expect(user.email).to eq(info[:email])
    end

    scenario 'sign in' do
      provider = :google_oauth2
      info = {first_name: "Bart", email: "bart@evergreen.com"}
      uid = mock_auth(provider, info)
      user = UserFactory.create_with_omniauth(uid: uid, provider: provider)

      visit  new_user_session_path
      click_link 'google_sign_in'

      user_count = User.where(uid: uid, provider: provider).count
      expect(user_count).to eq(1)
    end
  end

  describe "facebook" do
    scenario 'sign up' do
      info = {first_name: "Maggie", email: "maggie@evergreen.com"}
      uid = mock_auth(:facebook, info)
      
      visit  new_user_registration_path
      click_link 'Sign in with Facebook'

      user = User.where(uid: uid, provider: :facebook).first
      expect(user.name).to eq(info[:first_name])
      expect(user.email).to eq(info[:email])
    end

    scenario 'sign in' do
      provider = :facebook
      uid = mock_auth(:facebook, {first_name: "Maggie"})
      user = UserFactory.create_with_omniauth(uid: uid, provider: provider)

      visit  new_user_session_path
      click_link 'Sign in with Facebook'

      user_count = User.where(uid: uid, provider: provider).count
      expect(user_count).to eq(1)
    end
  end

  def mock_auth(provider, info)
    uid = SecureRandom.hex(10)
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(uid: uid, 
                                                                 provider: provider, 
                                                                 info: info)
    uid
  end
end
