class AddCommentsCountToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :comments_count, :integer, default: 0
  end
end
