require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "topページ" do
    before do
      visit root_path
    end

    it "「music_sns」の文字列が存在することを確認" do
      expect(page).to have_content 'music_sns'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title
    end

    context "ライブ同行者投稿フィード", js: true do
      let!(:user) { create(:user) }
      let!(:live_companion) { create(:live_companion, user: user) }

      before do
        login_for_system(user)
      end

      it "ライブ同行者投稿のぺージネーションが表示されること" do
        login_for_system(user)
        create_list(:live_companion, 6, user: user)
        visit root_path
        expect(page).to have_content "一緒にライブに行く人を見つけよう！ (#{user.live_companions.count})"
        expect(page).to have_css "div.pagination"
        LiveCompanion.take(5).each do |d|
          expect(page).to have_link d.artist_name
        end
      end

      it "「一緒にライブに行く人を募集する」リンクが表示されること" do
        visit root_path
        expect(page).to have_link "一緒にライブに行く人を募集する", href: new_live_companion_path
      end
    end
  end

  describe "使い方ページ" do
    before do
      visit about_path
    end

    it "「music_sns」とは？の文字列が存在することを確認" do
      expect(page).to have_content 'music_snsとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('music_snsとは？')
    end
  end
end
