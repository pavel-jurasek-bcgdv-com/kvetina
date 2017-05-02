# frozen_string_literal: true
# This worker is responsible for poll all unpaid rentals
class ImportWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'import_worker'

  def perform(linka, path)
    require 'rake'
    Rails.application.load_tasks
    Rake::Task["kvetina:import_errors"].reenable
    Rake::Task["kvetina:import_errors"].invoke(linka, path)
  end
end
