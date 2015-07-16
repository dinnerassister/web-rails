Devise.setup do |config|
  config.mailer_sender = 'no-reply@dinnerassister.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72

  config.lock_strategy = :failed_attempts
  config.unlock_keys = [:email]
  config.unlock_strategy = :email
  config.maximum_attempts = 5
  config.reset_password_keys = [:email]
  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.omniauth :google_oauth2, Rails.application.secrets.omni_google_id, Rails.application.secrets.omni_google_key
  config.omniauth :facebook, Rails.application.secrets.omni_facebook_id, Rails.application.secrets.omni_facebook_key
  config.omniauth :twitter, Rails.application.secrets.omni_twitter_id,Rails.application.secrets.omni_twitter_key

end