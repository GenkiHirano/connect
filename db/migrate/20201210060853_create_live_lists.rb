class CreateLiveLists < ActiveRecord::Migration[6.0]
  def change
    create_table :live_lists do |t|
      t.integer :user_id
      t.integer :live_companion_id
      t.timestamps
    end
    add_index :live_lists, [:user_id, :live_companion_id], unique: true
  end
end
