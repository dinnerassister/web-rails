class UserCallbacksController < Devise::OmniauthCallbacksController

  [:google_oauth2, :twitter, :facebook].each do |method|
    define_method method do
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
  end
end