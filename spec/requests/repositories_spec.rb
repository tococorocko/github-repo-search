require 'rails_helper'

RSpec.describe "Request to repositories", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/repositories"
      expect(response).to have_http_status(:success)
    end
  end

end
