class AddUserToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :user, foreign_key: true
  end
end
