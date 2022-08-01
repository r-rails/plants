# frozen_string_literal: true

class AddColumnsToPlant < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :img, :string
    add_column :plants, :climate, :string
    add_column :plants, :ideallight, :string
    add_column :plants, :watering, :string
    add_column :plants, :category, :string
    add_column :plants, :latin, :string
  end
end
