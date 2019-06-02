class AddTicketToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :ticket, foreign_key: true
  end
end
