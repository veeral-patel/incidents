class AddPriorityToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_reference :incidents, :priority, foreign_key: true
  end
end
