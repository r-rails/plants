class RemoveImgFromPlant < ActiveRecord::Migration[7.0]
  def change
    remove_column :plants, :img, :string
  end
end
