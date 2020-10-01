# frozen_string_literal: true

class CreateMeasurements < ActiveRecord::Migration[6.0]
  def change
    create_table :measurements do |t|
      t.numeric :duration
      t.string :date
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
