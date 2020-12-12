require 'rails_helper'

RSpec.describe "ライブ予定リスト登録機能", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) } 
  let(:live_companion) { create(:live_companion, user: other_user) } 

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

  context "リスト登録/解除機能" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
      end

      it "ライブのリスト登録/解除ができること" do
        expect {
          post "/live_lists/#{live_companion.id}/create"
        }.to change(other_user.live_lists, :count).by(1)
        expect {
          delete "/live_lists/#{LiveList.first.id}/destroy"
        }.to change(other_user.live_lists, :count).by(-1)
      end

      it "ライブのAjaxによるリスト登録/解除ができること" do
        expect {
          post "/live_lists/#{live_companion.id}/create", xhr: true
        }.to change(other_user.live_lists, :count).by(1)
        expect {
          delete "/live_lists/#{LiveList.first.id}/destroy", xhr: true
        }.to change(other_user.live_lists, :count).by(-1)
      end
    end

    context "ログインしていない場合" do
      it "リスト登録は実行できず、ログインページへリダイレクトすること" do
        expect {
          post "/live_lists/#{live_companion.id}/create"
        }.not_to change(LiveList, :count)
        expect(response).to redirect_to login_path
      end

      it "リスト解除は実行できず、ログインページへリダイレクトすること" do
        expect {
          delete "/live_lists/#{live_companion.id}/destroy"
        }.not_to change(LiveList, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end
