class AddBackStatusToTicket < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :status, foreign_key: true
  end
end
