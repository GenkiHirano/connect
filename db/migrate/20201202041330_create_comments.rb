class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :live_companion_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
