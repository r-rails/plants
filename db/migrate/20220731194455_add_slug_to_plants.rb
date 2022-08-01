class AddSlugToPlants < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :slug, :string
    add_index :plants, :slug, unique: true
  end
end
