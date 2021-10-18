class ChangeCreateUserIdToBeReferencesInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :create_user_id, :integer, foreign_key: true
    change_column :users, :update_user_id, :integer, foreign_key: true
  end
end
