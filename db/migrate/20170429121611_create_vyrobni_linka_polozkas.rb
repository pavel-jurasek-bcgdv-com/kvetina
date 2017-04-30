class CreateVyrobniLinkaPolozkas < ActiveRecord::Migration[5.0]
  def change
    create_table :vyrobni_linka_polozkas do |t|
      t.integer :vyrobni_linka_id
      t.date :datum
      t.integer :dobre_kusy
      t.integer :nok_ftf
      t.integer :ok_ftf
      t.integer :nok_rq
      t.float :rq
      t.float :rq_cil
      t.float :zm_rq
      t.float :ftf
      t.integer :ftf_cil
      t.integer :zm_ftf
      t.integer :zmetky
      t.integer :opakovany_test
      t.integer :rework

      t.timestamps
    end
    add_index :vyrobni_linka_polozkas, :vyrobni_linka_id
  end
end
