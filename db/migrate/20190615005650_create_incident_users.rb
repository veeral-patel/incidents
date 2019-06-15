class CreateIncidentUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :incidents_users do |t|
      t.references :user, foreign_key: true
      t.references :incident, foreign_key: true
    end
  end
end