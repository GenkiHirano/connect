require 'rails_helper'

RSpec.describe "LiveCompanions", type: :system do
  let!(:user) { create(:user) }
  let!(:live_companion) { create(:live_companion, user: user) }

  describe "ライブ同行者募集投稿ページ" do
    before do
      login_for_system(user)
      visit new_live_companion_path
    end

    context "ページレイアウト" do
      it "「一緒にライブに行く人を募集する」の文字列が存在すること" do
        expect(page).to have_content '一緒にライブに行く人を募集する'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('一緒にライブに行く人を募集する')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'アーティスト名'
        expect(page).to have_content 'ライブ名'
        expect(page).to have_content 'ライブメモ'
      end
    end

    context "ライブ同行者募集投稿処理" do
      it "有効な情報でライブ同行者募集投稿を行うと「ライブ同行者の募集が完了しました！」のフラッシュが表示されること" do
        fill_in "アーティスト名", with: "米津玄師"
        fill_in "ライブ名", with: "米津玄師 2020 TOUR / HYPE"
        fill_in "ライブメモ", with: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
        click_button "登録する"
        expect(page).to have_content "ライブ同行者の募集が完了しました！"
      end

      it "無効な情報でライブ同行者募集投稿を行うと登録失敗のフラッシュが表示されること" do
        fill_in "アーティスト名", with: ""
        fill_in "ライブ名", with: "米津玄師 2020 TOUR / HYPE"
        fill_in "ライブメモ", with: "誰か、米津玄師さんの一緒にライブ行きませんか...？"
        click_button "登録する"
        expect(page).to have_content "アーティスト名を入力してください"
      end
    end
  end

  describe "投稿詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit live_companion_path(live_companion)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{live_companion.artist_name}")
      end

      it "ライブ情報が表示されること" do
        expect(page).to have_content live_companion.artist_name
        expect(page).to have_content live_companion.live_name
        expect(page).to have_content live_companion.live_memo
      end
    end
  end
end
