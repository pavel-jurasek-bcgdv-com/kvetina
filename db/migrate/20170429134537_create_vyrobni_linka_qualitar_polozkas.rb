class CreateVyrobniLinkaQualitarPolozkas < ActiveRecord::Migration[5.0]
  def change
    create_table :vyrobni_linka_qualitar_polozkas do |t|
      t.integer :vyrobni_linka_id
      t.integer :external_record
      t.integer :poradi_id
      t.date :datum
      t.time :cas
      t.string :zakazka
      t.string :typ
      t.string :v_cislo
      t.string :pripojka
      t.string :otvor
      t.string :delka_sroubu
      t.string :testnost
      t.string :prachovka
      t.boolean :lisovani_nok
      t.string :otvor1
      t.string :otvor2
      t.string :otvor3
      t.string :otvor4
      t.string :otvor5
      t.string :otvor6
      t.string :zatka1
      t.string :zatka2
      t.string :zatka3
      t.string :zatka4
      t.string :zatka5
      t.string :zatka6
      t.string :vyska_tlac_t
      t.string :vyska_pist_t
      t.boolean :pist_nok
      t.boolean :tlac_nok
      t.string :vyska_tlac
      t.string :d_limit_s
      t.string :d_limit_f
      t.string :h_limit_s
      t.string :h_limit_f
      t.string :s1
      t.string :f1
      t.string :s2
      t.string :f2
      t.string :s3
      t.string :f3
      t.string :s4
      t.string :f4
      t.string :s5
      t.string :f5
      t.float :tesnost_pr
      t.float :tesnost_bar
      t.time :cas_testu
      t.string :vysledek
      t.string :poradi_ks
      t.string :cislo_tlac
      t.string :obsluha
      t.string :index_pracovnika
      t.string :paleta
      t.string :tester
      t.string :cisteni
      t.string :prujezdy
      t.string :odsroubovani
      t.string :plech_app
      t.string :tlak_sila
      t.string :tlak_tes
      t.string :moment_bocni
      t.string :moment_celni
      t.string :kod_chyby

      t.timestamps
    end
    add_index :vyrobni_linka_qualitar_polozkas, :vyrobni_linka_id
  end
end
