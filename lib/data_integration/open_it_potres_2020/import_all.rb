class DataIntegration::OpenItPotres2020
  class ImportAll
    include Functional
    include Backgroundable

    sidekiq_options lock: :until_and_while_executing

    FOREIGN_SYSTEM = DataIntegration::OpenItPotres2020::NAME


    def call
      api = DataIntegration::OpenItPotres2020.new
      foreign_cases = api.fetch_cases

      ActiveRecord::Base.transaction do
        Ticket.where(foreign_system: FOREIGN_SYSTEM).update_all(status: 'disabled')
        foreign_cases.each do |foreign_case|
          ::Rails.logger.debug "Importing #{FOREIGN_SYSTEM} ID #{foreign_case['id']}"
          ImportSingle[foreign_case]
        end
      end
    end

  end
end
