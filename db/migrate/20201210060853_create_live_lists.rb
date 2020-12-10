class CreateLiveLists < ActiveRecord::Migration[6.0]
  def change
    create_table :live_lists do |t|
      t.integer :user_id
      t.integer :live_companion_id
      t.integer :from_user_id

      t.timestamps
    end
  end
end
