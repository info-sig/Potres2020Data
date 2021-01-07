class DataIntegration::OpenItPotres2020
  class ImportAll
    include Functional
    include Backgroundable

    sidekiq_options lock: :until_and_while_executing

    FOREIGN_SYSTEM = DataIntegration::OpenItPotres2020::NAME


    def call
      api = DataIntegration::OpenItPotres2020.new
      foreign_cases = api.fetch_cases

      last_version = Ticket.version_seq_curval + 1

      foreign_cases.each do |foreign_case|
        ::Rails.logger.debug "Importing #{FOREIGN_SYSTEM} ID #{foreign_case['id']}"
        rv = ImportSingle[foreign_case]
        # puts rv.slice(:t_changed, :ft_changed)
      end
    end

  end
end
