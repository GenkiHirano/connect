class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :live_companion_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :live_companion_id  
  end
end
