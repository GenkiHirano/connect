require 'rails_helper'

RSpec.describe "ライブ予定リスト登録機能", type: :request do
  let(:user) { create(:user) }

  context "ライブ予定リスト一覧ページの表示" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_for_request(user)
        get live_lists_path
        expect(response).to have_http_status "200"
        expect(response).to render_template('live_lists/index')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get live_lists_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end
end
