class CreateLiveCompanions < ActiveRecord::Migration[6.0]
  def change
    create_table :live_companions do |t|
      t.string :artist_name
      t.string :live_name
      t.date :schedule
      t.text :live_memo
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :live_companions, [:user_id, :created_at]
  end
end
