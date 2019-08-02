class RemoveStatusFromTicket < ActiveRecord::Migration[5.2]
  def change
    remove_column :tickets, :status
  end
end
