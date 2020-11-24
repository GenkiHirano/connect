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
