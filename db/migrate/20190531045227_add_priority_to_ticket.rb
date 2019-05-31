class AddPriorityToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :priority, :integer
  end
end
