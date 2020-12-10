require 'rails_helper'

RSpec.describe "LiveLists", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/live_lists/index"
      expect(response).to have_http_status(:success)
    end
  end

end
