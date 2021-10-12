class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :status, :limit=> 1, null: false
      t.integer :create_user_id, null: false
      t.integer :update_user_id, null: false
      t.integer :deleted_user_id, null: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
