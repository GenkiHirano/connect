require 'rails_helper'

RSpec.describe "コメント機能", type: :request do
  let!(:user) { create(:user) }
  let!(:live_companion) { create(:live_companion) }
  let!(:comment) { create(:comment, user_id: user.id, live_companion: live_companion) }

  context "コメントの登録" do
    context "ログインしている場合" do
    end

    context "ログインしていない場合" do
      it "コメントは登録できず、ログインページへリダイレクトすること" do
        expect {
          post comments_path, params: { live_companion_id: live_companion.id,
                                        comment: { content: "よかったら一緒に行きませんか...？ 私もちょうど行きたかったんです！" } }
        }.not_to change(live_companion.comments, :count)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "コメントの削除" do
    context "ログインしている場合" do
    end

    context "ログインしていない場合" do
      it "コメントの削除はできず、ログインページへリダイレクトすること" do
        expect {
          delete comment_path(comment)
        }.not_to change(live_companion.comments, :count)
      end
    end
  end
end
