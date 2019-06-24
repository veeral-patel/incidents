class CreateTicketTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_templates do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
