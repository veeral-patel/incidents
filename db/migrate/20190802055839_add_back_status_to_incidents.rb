class AddBackStatusToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_reference :incidents, :status, foreign_key: true
  end
end
