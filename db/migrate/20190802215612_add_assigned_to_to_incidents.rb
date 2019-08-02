class AddAssignedToToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_reference :incidents, :assigned_to, foreign_key: { to_table: :users }
  end
end
