class ChangeColumnNameOnUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :admin
    add_column :users, :status, :integer, default: 0
  end
end
