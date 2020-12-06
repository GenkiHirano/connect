require 'rails_helper'

RSpec.describe "ライブ同行者を募集する(投稿)", type: :request do
  let!(:user) { create(:user) }
  let!(:live_companion) { create(:live_companion, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_live_companion.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }

  context "ログインしているユーザーの場合" do
    before do
      get new_live_companion_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_live_companion_url
      end
    end

    it "有効なライブ同行者データで投稿できること" do
      expect {
        post live_companions_path, params: {
          live_companion: { artist_name: "米津玄師",
                            live_name: "米津玄師 2020 TOUR / HYPE",
                            live_memo: "誰か、米津玄師さんの一緒にライブ行きませんか...？",
                            picture: picture }
        }
      }.to change(LiveCompanion, :count).by(1)
      follow_redirect!
      expect(response).to render_template('live_companions/show')
    end

    it "無効なライブ同行者データでは投稿できないこと" do
      expect {
        post live_companions_path, params: {
          live_companion: { artist_name: "",
                            live_name: "米津玄師 2020 TOUR / HYPE",
                            live_memo: "誰か、米津玄師さんの一緒にライブ行きませんか...？",
                            picture: picture }
        }
      }.not_to change(LiveCompanion, :count)
      expect(response).to render_template('live_companions/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_live_companion_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
