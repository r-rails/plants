class AddDeletedAtToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :deleted_at, :datetime, default: nil
  end
end
