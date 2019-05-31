class AddIsleadToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :is_lead, :boolean
  end
end
