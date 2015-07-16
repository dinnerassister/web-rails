require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #howto" do
    it "returns http success" do
      get :howto
      expect(response).to have_http_status(:success)
    end
  end

end
