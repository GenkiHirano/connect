require 'rails_helper'

RSpec.describe "ユーザー登録", type: :request do

  before do
    get signup_path
  end

  describe "正常なレスポンスを返すこと" do
    it "returns http success" do
      expect(response).to have_http_status "200"
    end
  end
end
