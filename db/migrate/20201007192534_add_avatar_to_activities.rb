class AddAvatarToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :avatar, :string
  end
end
