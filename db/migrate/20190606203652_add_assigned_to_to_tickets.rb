class AddAssignedToToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :assigned_to, foreign_key: true
  end
end
