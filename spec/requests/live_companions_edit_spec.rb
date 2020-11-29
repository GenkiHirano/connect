require "rails_helper"

RSpec.describe "投稿編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:live_companion) { create(:live_companion, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_live_companion_path(live_companion)
      login_for_request(user)
      expect(response).to redirect_to edit_live_companion_url(live_companion)
      patch live_companion_path(live_companion), params: { live_companion: {
        artist_name: "米津玄師",
        live_name: "米津玄師 2020 TOUR / HYPE",
        live_memo: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
      } }
      redirect_to live_companion
      follow_redirect!
      expect(response).to render_template('live_companions/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get edit_live_companion_path(live_companion)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      patch live_companion_path(live_companion), params: { live_companion: {
        artist_name: "米津玄師",
        live_name: "米津玄師 2020 TOUR / HYPE",
        live_memo: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
      } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      login_for_request(other_user)
      get edit_live_companion_path(live_companion)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      patch live_companion_path(live_companion), params: { live_companion: {
        artist_name: "米津玄師",
        live_name: "米津玄師 2020 TOUR / HYPE",
        live_memo: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
      } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
