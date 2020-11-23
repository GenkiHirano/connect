require 'rails_helper'

RSpec.describe "ユーザー登録", type: :request do
  before do
    get signup_path
  end

  describe "ユーザー登録ページ" do
    it "正常なレスポンスを返すこと" do
      expect(response).to have_http_status "200"
    end
  end
end
