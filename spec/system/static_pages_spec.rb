require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "topページ" do
    before do
      visit root_path
    end

    it "music_snsの文字列が存在することを確認" do
      expect(page).to have_content 'music_sns'
    end
  end

  describe "使い方ページ" do
    before do
      visit about_path
    end

    it "music_snsとは？の文字列が存在することを確認" do
      expect(page).to have_content 'music_snsとは？'
    end
  end
end
