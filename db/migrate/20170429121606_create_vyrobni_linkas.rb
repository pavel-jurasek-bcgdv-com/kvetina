class CreateVyrobniLinkas < ActiveRecord::Migration[5.0]
  def change
    create_table :vyrobni_linkas do |t|
      t.string :nazev
      t.integer :maximum_chyb

      t.timestamps
    end
  end
end
