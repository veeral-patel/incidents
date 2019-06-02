class CreateObservables < ActiveRecord::Migration[5.2]
  def change
    create_table :observables do |t|
      t.string :observable
      t.references :user, foreign_key: true
      t.references :ticket, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
