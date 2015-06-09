require "spec_helper"
require "rails_helper"

RSpec.describe UsersController, :type => :controller do

  describe "when user is not signed in" do
    [:show, :edit, :update].each do |action|
      it "will asks user to sign in on #{action}" do
        get action
        expect(response.body).to match("sign_in")
      end      
    end
  end

  describe "authenticated user" do
    include Devise::TestHelpers

    let(:user) {UserFactory.create}

    before(:each) do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "gets the user for editing" do
      get :edit
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :edit
      expect(assigns(:user)).to eq(user)
    end

    it "shows the user" do
      get :show
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :show
      expect(assigns(:user)).to eq(user)
    end

    describe "updates user" do
      let(:new_fields) { {name: "Lisa",
                          email: "lisa@evergreen.com"}
                        }

      it "saves the new field" do
        patch :update, {user: new_fields}
        updated_user = User.find(user.id)

        expect(updated_user.name).to eq new_fields[:name]
        expect(updated_user.email).to eq new_fields[:email]
      end

      it "redirects user to show after a successful update" do
        patch :update, {user: new_fields}
        expect(response).to redirect_to(user_path) 
      end

      it "notifies user of a successful update" do
        patch :update, {user: new_fields}
        expect(flash[:notice]).to eq 'User was successfully updated.'
      end

      it "shows the edit page if saving user fails" do
        patch :update, {user: {email: ""}}
        expect(assigns(:user).errors).to_not be_nil
        expect(response).to render_template :edit
      end
    end
  end
end