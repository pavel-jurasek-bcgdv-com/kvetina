# frozen_string_literal: true

namespace :kvetina do
  desc 'Import export-chyby.xlsx'
  task :import_errors => [:environment] do |t, args|
    args = args.to_a

    linka_db = VyrobniLinka.find_by(nazev: args.first)

    errors_report_path = args.second

    doc = SimpleXlsxReader.open(errors_report_path)

    data_db = doc.sheets.first.rows.map do |row|
      if row[2].is_a?(Date)
        {
          vyrobni_linka_id: linka_db.id,
          external_record: row[0],
          poradi_id: row[1],
          datum: row[2],
          cas: row[3],
          zakazka: row[4],
          typ: row[5],
          v_cislo: row[6],
          pripojka: row[7],
          otvor: row[8],
          delka_sroubu: row[9],
          testnost: row[10],
          prachovka: row[11],
          lisovani_nok: row[12],
          otvor1: row[13],
          otvor2: row[14],
          otvor3: row[15],
          otvor4: row[16],
          otvor5: row[17],
          otvor6: row[18],
          zatka1: row[19],
          zatka2: row[20],
          zatka3: row[21],
          zatka4: row[22],
          zatka5: row[23],
          zatka6: row[24],
          vyska_tlac_t: row[25],
          vyska_pist_t: row[26],
          pist_nok: row[27],
          tlac_nok: row[28],
          vyska_tlac: row[29],
          d_limit_s: row[30],
          d_limit_f: row[31],
          h_limit_s: row[32],
          h_limit_f: row[33],
          s1: row[34],
          f1: row[35],
          s2: row[36],
          f2: row[37],
          s3: row[38],
          f3: row[39],
          s4: row[40],
          f4: row[41],
          s5: row[42],
          f5: row[43],
          tesnost_pr: row[44],
          tesnost_bar: row[45],
          cas_testu: row[46].to_s.split(' ')[1],
          vysledek: row[47],
          poradi_ks: row[48],
          cislo_tlac: row[49],
          obsluha: row[50].strip,
          index_pracovnika: row[51],
          paleta: row[52],
          tester: row[53],
          cisteni: row[54],
          prujezdy: row[55],
          odsroubovani: row[56],
          plech_app: row[57],
          tlak_sila: row[58],
          tlak_tes: row[59],
          moment_bocni: row[60],
          moment_celni: row[61],
          kod_chyby: row[62]
        }
      else
        nil
      end
    end.compact

    VyrobniLinkaQualitarPolozka.delete_all
    VyrobniLinkaQualitarPolozka.create(data_db)

    puts 'Hotovo :)'
  end
end
