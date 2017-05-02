require 'obc_2_spreadsheet_xlsx'

ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  page_action :export, method: :post do
    send_data(
      Obc2SpreadsheetXlsx.render,
      filename: 'OBC 2.xlsx'
    )
  end

  page_action :denni_report_import_form, method: :get do
    render "denni_report_import_form"
  end

  page_action :chyby_report_import_form, method: :get do
    render "chyby_report_import_form"
  end

  page_action :denni_report_import, method: :post do
    require 'rake'
    Rails.application.load_tasks
    Rake::Task["kvetina:import"].reenable
    Rake::Task["kvetina:import"].invoke(params['import']['data'].path)

    redirect_to admin_dashboard_path, notice: 'Hotovo :] Denni import done.'
  end

  page_action :chyby_report_import_form2, method: :post do
    render "chyby_report_import_form2"
  end

  page_action :chyby_report_import2, method: :post do
    require 'rake'
    Rails.application.load_tasks
    Rake::Task["kvetina:import_errors"].reenable
    Rake::Task["kvetina:import_errors"].invoke(params['import']['linka'], Rails.root.join('tmp/test.xslx').to_s)

    redirect_to admin_dashboard_path, notice: 'Hotovo :] Chyby import done... Pocket chvilinku cca 3min'
  end

  page_action :chyby_report_import, method: :post do
    uploaded = params['import']['data']
    File.open(Rails.root.join('tmp/test.xslx').to_s, 'w') do |file|
      file.write(uploaded.read)
    end

    redirect_to admin_dashboard_chyby_report_import2_form_path, method: :get
  end

  action_item :export do
    link_to "Export", admin_dashboard_export_path, method: :post
  end

  action_item :denni_report_import do
    link_to "Denni report import", admin_dashboard_denni_report_import_form_path, method: :get
  end

  action_item :chyby_report_import do
    link_to "Chyby report import", admin_dashboard_chyby_report_import_form_path, method: :get
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #

    columns do
      column do
        panel "Chyby 1 - 6 (bez kontroly)" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            VyrobniLinkaQualitarPolozka.group(:kod_chyby).count.each do |kod_chyby, count|
              if (1..6).include? kod_chyby.to_i
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
          end
        end
      end

      column do
        result = VyrobniLinkaQualitarPolozka.where(otvor1: 'NOK').or(VyrobniLinkaQualitarPolozka.where(otvor2: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor3: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor4: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor5: 'NOK')).or(VyrobniLinkaQualitarPolozka.where(otvor6: 'NOK'))
        panel('Otvor 1-6') do
          para('Pocet chyb otvor nenalezeno: ' + result.count.to_s)
        end
      end

      column do
        result = VyrobniLinkaQualitarPolozka.where(zatka1: 'Ned').or(VyrobniLinkaQualitarPolozka.where(zatka2: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka3: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka4: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka5: 'Ned')).or(VyrobniLinkaQualitarPolozka.where(zatka6: 'Ned'))
        panel('Zatka 1-6') do
          para('Pocet chyb otvor nenalezeno: ' + result.count.to_s)
        end
      end
    end
    columns do
      column do
        panel "Pist NOK" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            VyrobniLinkaQualitarPolozka.group(:pist_nok).count.each do |kod_chyby, count|
              if kod_chyby
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
          end
        end
      end
      column do
        panel "Tlac NOK" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            VyrobniLinkaQualitarPolozka.group(:tlac_nok).count.each do |kod_chyby, count|
              if kod_chyby
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
          end
        end
      end

      column do
        panel "Vyska Tlacitka -" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            suma = 0
            VyrobniLinkaQualitarPolozka.group(:vyska_tlac).count.each do |kod_chyby, count|
              if kod_chyby.to_f < 14.5
                suma += count
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
            tr do
              th 'Celkem'
              th suma
            end
          end
        end
      end

      column do
        panel "Vyska Tlacitka +" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            suma = 0
            VyrobniLinkaQualitarPolozka.group(:vyska_tlac).count.each do |kod_chyby, count|
              if kod_chyby.to_f > 15.5
                suma += count
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
            tr do
              th 'Celkem'
              th suma
            end
          end
        end
      end

    end
    columns do

      column do
        panel "Sila (F1)" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            VyrobniLinkaQualitarPolozka.group(:kod_chyby).count.each do |kod_chyby, count|
              if (25..25).include? kod_chyby.to_i
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
          end
        end
      end

      column do
        panel "Testnost PR tesnost-" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            suma = 0
            VyrobniLinkaQualitarPolozka.group(:tesnost_pr).count.each do |kod_chyby, count|
              if kod_chyby.to_f <= -10
                suma += count
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
            tr do
              th 'Celkem'
              th suma
            end
          end
        end
      end

      column do
        panel "Testnost PR tesnost+" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            suma = 0
            VyrobniLinkaQualitarPolozka.group(:tesnost_pr).count.each do |kod_chyby, count|
              if kod_chyby.to_f > 10
                suma += count
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
            tr do
              th 'Celkem'
              th suma
            end
          end
        end
      end
    end
    columns do
      column do
        panel "Tesnost Bar" do
          table do
              tr do
                th 'Kod chyby', width: '20%'
                th 'Pocet'
              end
            VyrobniLinkaQualitarPolozka.group(:kod_chyby).count.each do |kod_chyby, count|
              if (35..35).include? kod_chyby.to_i
                tr do
                  td kod_chyby
                  td count
                end
              end
            end
          end
        end
      end
    end

  end # content
end
