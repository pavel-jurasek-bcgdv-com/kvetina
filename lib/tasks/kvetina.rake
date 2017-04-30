# frozen_string_literal: true

namespace :kvetina do
  desc 'Import denni-report.xlsx'
  task :import => [:environment] do |t, args|
    denni_report_path = args.to_a.first
    doc = SimpleXlsxReader.open(denni_report_path)
    data = doc.sheets.first.rows

    linky_num = -1
    linky = data.each_with_index.with_object({}) do |(data, index), result|
      data = data.compact

      result[:month] = data[3] if index.zero?
      result[:linky] ||= []

      if data.size == 1
        linky_num += 1
        result[:linky][linky_num] ||= {}
        result[:linky][linky_num][:name] = data[0]
        result[:linky][linky_num][:items] ||= []
      end

      if data.length == 14 && data[0].is_a?(Date)
        result[:linky][linky_num][:items] << {
          datum: data[0],
          dobre_kusy: data[1].to_i,
          nok_ftf: data[2].to_i,
          ok_ftf: data[3].to_i,
          nok_rq: data[4].to_i,
          rq: data[5] * 10000,
          rq_cil: data[6] * 10000,
          zm_rq: data[7] * 10000,
          ftf: data[8],
          ftf_cil: data[9],
          zm_ftf: data[10],
          zmetky: data[11].to_i,
          opakovany_test: data[12].to_i,
          rework: data[13].to_i
        }
      end
    end

    VyrobniLinka.delete_all
    VyrobniLinkaPolozka.delete_all

    linky[:linky].each do |linka|
      linka_db = VyrobniLinka.new(nazev: linka[:name])
      linka_db.save
      linka_db.id

      VyrobniLinkaPolozka.create(
        linka[:items].map do |item|
          item[:vyrobni_linka_id] = linka_db.id
          item
        end
      )
    end

    puts 'Hotovo :)'
  end
end
