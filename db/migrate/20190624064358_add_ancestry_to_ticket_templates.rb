class AddAncestryToTicketTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :ticket_templates, :ancestry, :string
    add_index :ticket_templates, :ancestry
  end
end
