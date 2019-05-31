class AddStatusToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :status, :integer
  end
end
