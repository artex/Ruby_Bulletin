class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :password_digest
      t.string :profile
      t.integer :type, :limit => 1
      t.string :phone
      t.string :address
      t.date :dob
      t.integer :create_user_id
      t.integer :update_user_id
      t.integer :deleted_user_id
      t.date :deleted_at
      t.timestamps
      
    end
  end
end
