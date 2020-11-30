require "rails_helper"

RSpec.describe "投稿の削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:live_companion) { create(:live_companion, user: user) }

  context "ログインしていて、自分の投稿を削除する場合" do
    it "処理が成功し、トップページにリダイレクトすること" do
      login_for_request(user)
      expect {
        delete live_companion_path(live_companion)
      }.to change(LiveCompanion, :count).by(-1)
      redirect_to user_path(user)
      follow_redirect!
      expect(response).to render_template('static_pages/top')
    end
  end

  context "ログインしていて、他人の投稿を削除する場合" do
    it "処理が失敗し、トップページへリダイレクトすること" do
      login_for_request(other_user)
      expect {
        delete live_companion_path(live_companion)
      }.not_to change(LiveCompanion, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end

  context "ログインしていない場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete live_companion_path(live_companion)
      }.not_to change(LiveCompanion, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
