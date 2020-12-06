require 'rails_helper'

RSpec.describe "気になる登録機能", type: :request do
  let(:user) { create(:user) }
  let(:live_companion) { create(:live_companion) }

  context "気になる一覧ページの表示" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_for_request(user)
        get favorites_path
        expect(response).to have_http_status "200"
        expect(response).to render_template('favorites/index')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get favorites_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end

  context "気になる登録処理" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
      end

      it "投稿の気になる登録ができること" do
        expect {
          post "/favorites/#{live_companion.id}/create"
        }.to change(user.favorites, :count).by(1)
      end

      it "投稿のAjaxによる気になる登録ができること" do
        expect {
          post "/favorites/#{live_companion.id}/create", xhr: true
        }.to change(user.favorites, :count).by(1)
      end

      it "投稿の気になる解除ができること" do
        user.favorite(live_companion)
        expect {
          delete "/favorites/#{live_companion.id}/destroy"
        }.to change(user.favorites, :count).by(-1)
      end

      it "投稿のAjaxによる気になる解除ができること" do
        user.favorite(live_companion)
        expect {
          delete "/favorites/#{live_companion.id}/destroy", xhr: true
        }.to change(user.favorites, :count).by(-1)
      end
    end

    context "ログインしていない場合" do
      it "気になる登録は実行できず、ログインページへリダイレクトすること" do
        expect {
          post "/favorites/#{live_companion.id}/create"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_path
      end

      it "気になる解除は実行できず、ログインページへリダイレクトすること" do
        expect {
          delete "/favorites/#{live_companion.id}/destroy"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end
