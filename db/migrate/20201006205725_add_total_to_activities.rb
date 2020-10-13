# frozen_string_literal: true

class AddTotalToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :total, :string
  end
end
