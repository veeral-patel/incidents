class AddDescriptionToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_column :incidents, :description, :string
  end
end
