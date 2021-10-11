class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :profile
      t.boolean :type
      t.string :phone
      t.string :address
      t.date :dob
      t.integer :create_user_id
      t.integer :update_user_id
      t.integer :deleted_user_id

      t.timestamps
    end
  end
end
