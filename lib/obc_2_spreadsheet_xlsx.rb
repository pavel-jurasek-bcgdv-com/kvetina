class Obc2SpreadsheetXlsx
  def self.render
    Axlsx::Package.new do |package|
      package = chyby16(package)
      package = otvor1_6(package)
      package = zatka1_6(package)
      package = pist_nok(package)
      package = tlac_nok(package)
      package = vyska_tlacitka_minus(package)
      package = vyska_tlacitka_plus(package)
      package = sila_f1(package)
      package = tesnost_pr_minus(package)
      package = tesnost_pr_plus(package)
      package = tesnost_bar(package)
      package
    end.to_stream.string.force_encoding('binary')
  end

  def self.tesnost_pr_minus(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Tesnost PR tesnost-') do |sheet|
      sheet.add_row ['Tesnost PR tesnost-']
      sheet.add_row ['Kod chyby', 'Pocet']
      suma = 0
      VyrobniLinkaQualitarPolozka.group(:tesnost_pr).count.each do |kod_chyby, count|
        if kod_chyby.to_f <= -10
          suma += count
          sheet.add_row [kod_chyby, count]
        end
      end
      sheet.add_row ['Celkem', suma]
    end
    package
  end

  def self.tesnost_pr_plus(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Tesnost PR tesnost+') do |sheet|
      sheet.add_row ['Tesnost PR tesnost+']
      sheet.add_row ['Kod chyby', 'Pocet']
      suma = 0
      VyrobniLinkaQualitarPolozka.group(:tesnost_pr).count.each do |kod_chyby, count|
        if kod_chyby.to_f > 10
          suma += count
          sheet.add_row [kod_chyby, count]
        end
      end
      sheet.add_row ['Celkem', suma]
    end
    package
  end

  def self.sila_f1(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Sila (F1)') do |sheet|
      sheet.add_row ['Sila (F1)']
      sheet.add_row ['Kod chyby', 'Pocet']
      VyrobniLinkaQualitarPolozka.group(:kod_chyby).count.each do |kod_chyby, count|
        if (25..25).include? kod_chyby.to_i
          sheet.add_row [kod_chyby, count]
        end
      end
    end
    package
  end

  def self.tesnost_bar(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Tesnost Bar') do |sheet|
      sheet.add_row ['Tesnost Bar']
      sheet.add_row ['Kod chyby', 'Pocet']
      VyrobniLinkaQualitarPolozka.group(:kod_chyby).count.each do |kod_chyby, count|
        if (35..35).include? kod_chyby.to_i
          sheet.add_row [kod_chyby, count]
        end
      end
    end
    package
  end

  def self.pist_nok(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Pist NOK') do |sheet|
      sheet.add_row ["Pist NOK"]
      sheet.add_row ['Kod chyby', 'Pocet']
      VyrobniLinkaQualitarPolozka.group(:pist_nok).count.each do |kod_chyby, count|
        if kod_chyby
          sheet.add_row [kod_chyby, count]
        end
      end
    end
    package
  end

  def self.tlac_nok(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Tlac NOK') do |sheet|
      sheet.add_row ["Tlac NOK"]
      sheet.add_row ['Kod chyby', 'Pocet']
      VyrobniLinkaQualitarPolozka.group(:tlac_nok).count.each do |kod_chyby, count|
        if kod_chyby
          sheet.add_row [kod_chyby, count]
        end
      end
    end
    package
  end

  def self.vyska_tlacitka_minus(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Vyska Tlacitka -') do |sheet|
      sheet.add_row ["Vyska Tlacitka -"]
      suma = 0
      VyrobniLinkaQualitarPolozka.group(:vyska_tlac).count.each do |kod_chyby, count|
        if kod_chyby.to_f < 14.5
          suma += count
          sheet.add_row [kod_chyby, count]
        end
      end
      sheet.add_row ['Celkem', suma]
    end
    package
  end

  def self.vyska_tlacitka_plus(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Vyska Tlacitka +') do |sheet|
      sheet.add_row ["Vyska Tlacitka +"]
      suma = 0
      VyrobniLinkaQualitarPolozka.group(:vyska_tlac).count.each do |kod_chyby, count|
        if kod_chyby.to_f > 15.5
          suma += count
          sheet.add_row [kod_chyby, count]
        end
      end
      sheet.add_row ['Celkem', suma]
    end
    package
  end

  def self.otvor1_6(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Otvor 1 - 6') do |sheet|
      sheet.add_row ["Otvor 1 - 6"]
      result = VyrobniLinkaQualitarPolozka.where(otvor1: 'NOK').or(VyrobniLinkaQualitarPolozka.where(otvor2: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor3: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor4: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor5: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor6: 'NOK'))
      sheet.add_row ['Pocet chyb otvor nenalezeno: ', result.count.to_s]
    end
    package
  end

  def self.zatka1_6(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Zatka 1 - 6') do |sheet|
      sheet.add_row ["Zatka 1 - 6"]
      result = VyrobniLinkaQualitarPolozka.where(zatka1: 'Ned').or(VyrobniLinkaQualitarPolozka.where(zatka2: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka3: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka4: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka5: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka6: 'Ned'))
      sheet.add_row ['Pocet chyb otvor nenalezeno: ', result.count.to_s]
    end
    package
  end

  def self.chyby16(package)
    workbook = package.workbook
    workbook.add_worksheet(name: 'Chyby 1 - 6 (bez kontroly)') do |sheet|
      sheet.add_row ["Chyby 1 - 6 (bez kontroly)"]
      VyrobniLinkaQualitarPolozka.group(:kod_chyby).count.each do |kod_chyby, count|
        if (1..6).include? kod_chyby.to_i
          sheet.add_row [kod_chyby, count]
        end
      end
    end
    package
  end
end
