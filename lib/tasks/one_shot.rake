namespace :one_shot do

  task :import_entire_potres2020_openit_hr => :environment do
    DataIntegration::OpenItPotres2020::ImportAll.perform_async
  end

end