class AddIndexToIncidentsUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :incidents_users, [:incident_id, :user_id], :unique => true
  end
end