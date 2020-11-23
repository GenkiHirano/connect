require 'rails_helper'
RSpec.describe ApplicationHelper, type: :helper do
  describe 'タイトル' do
    it "full_titleの引数が空の場合、タイトルは#{Const::BASE_TITLE}'と等しい" do
      expect(full_title("")).to eq Const::BASE_TITLE
    end

    it "full_titleの引数がnilの場合、タイトルは#{Const::BASE_TITLE}'と等しい" do
      expect(full_title(nil)).to eq Const::BASE_TITLE
    end

    it "full_titleの引数がtestの場合、タイトルは'test - #{Const::BASE_TITLE}'と等しい" do
      expect(full_title("test")).to eq "test - #{Const::BASE_TITLE}"
    end
  end
end
