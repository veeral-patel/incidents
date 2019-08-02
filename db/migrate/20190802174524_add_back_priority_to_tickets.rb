class AddBackPriorityToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :priority, foreign_key: true
  end
end
