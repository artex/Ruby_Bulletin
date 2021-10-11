class ChangeTypeToBeStringInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :type, :string
  end
end
