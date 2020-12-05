class AddPictureToLiveCompanions < ActiveRecord::Migration[6.0]
  def change
    add_column :live_companions, :picture, :string
  end
end
