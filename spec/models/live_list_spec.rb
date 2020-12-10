require 'rails_helper'

RSpec.describe LiveList, type: :model do
  let!(:live_list) { create(:live_list) }

  context "バリデーション" do
    it "live_listインスタンスが有効であること" do
      expect(live_list).to be_valid
    end

    it "user_idがnilの場合、無効であること" do
      live_list.user_id = nil
      expect(live_list).not_to be_valid
    end

    it "live_companion_idがnilの場合、無効であること" do
      live_list.live_companion_id = nil
      expect(live_list).not_to be_valid
    end

    it "from_user_idがnilの場合、無効であること" do
      live_list.from_user_id = nil
      expect(live_list).not_to be_valid
    end
  end
end
