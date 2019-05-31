class AddUserToCases < ActiveRecord::Migration[5.2]
  def change
    add_reference :incidents, :user, foreign_key: true
  end
end
