class CreateLiveCompanions < ActiveRecord::Migration[6.0]
  def change
    create_table :live_companions do |t|
      t.integer :user_id
      t.string :artist_name
      t.string :live_name
      t.date :schedule
      t.text :recruitment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
