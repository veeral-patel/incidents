class AddAncestryToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :ancestry, :string
    add_index :tickets, :ancestry
  end
end
