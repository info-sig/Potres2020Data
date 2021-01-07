class DataIntegration::OpenItPotres2020
  class ImportAll
    include Functional
    include Backgroundable

    sidekiq_options lock: :until_and_while_executing

    def call
      api = DataIntegration::OpenItPotres2020.new
      foreign_cases = api.fetch_cases
      foreign_cases.each do |foreign_case|
        ::Rails.logger.debug "Importing OpenItPotres2020 ID #{foreign_case['id']}"
        ImportSingle[foreign_case]
      end
    end

  end
end