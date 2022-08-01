# frozen_string_literal: true

class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name

      t.timestamps
    end
  end
end
