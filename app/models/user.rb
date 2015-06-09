class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :twitter, :facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email || "no-reply@dinnerassister.com"
      user.password = Devise.friendly_token[0,20]

      if auth.info.first_name
        user.name = auth.info.first_name
      else
        user.name = auth.info.name
      end
    end
  end

  def da_authenticated?
    uid.blank?
  end
end
