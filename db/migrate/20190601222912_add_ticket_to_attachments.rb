class AddTicketToAttachments < ActiveRecord::Migration[5.2]
  def change
    add_reference :attachments, :ticket, foreign_key: true
  end
end
