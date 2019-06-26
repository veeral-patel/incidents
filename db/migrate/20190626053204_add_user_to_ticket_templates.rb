class AddUserToTicketTemplates < ActiveRecord::Migration[5.2]
  def change
      add_reference :ticket_templates, :user, foreign_key: true
  end
end
