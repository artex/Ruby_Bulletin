class ChangeTypeFromPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :create_user_id, :bigint
    change_column :posts, :update_user_id, :bigint
  end
end
