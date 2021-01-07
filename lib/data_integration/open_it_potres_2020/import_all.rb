class DataIntegration::OpenItPotres2020
  class ImportAll
    include Functional
    include Backgroundable

    sidekiq_options lock: :until_and_while_executing

    def call
      api = DataIntegration::OpenItPotres2020.new
      rv = api.fetch_cases
      binding.pry
    end

  end
end
