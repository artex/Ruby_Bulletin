class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.integer :status
      t.integer :create_user_id, foreign_key: true
      t.integer :update_user_id, foreign_key: true
      t.integer :deleted_user_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
