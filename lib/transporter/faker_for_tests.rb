module Transporter
  class FakerForTests
    extend ClassFunctional

    def self.dont_fake!
      $online_transporter_in_tests = true
    end

    def self.call request
      $faked_api_exchange || raise('$faked_api_exchange not initialized')
      api_exchange = $faked_api_exchange.shift || {}
      raise "undefined response for '#{request}'" unless api_exchange[:response]

      request_validator = api_exchange[:request_validator]
      response = api_exchange[:response]

      request_validator&.call(request)
      response

    rescue Minitest::Assertion => e
      Event.trace_exception e, highlight: true, skip_framework: true
      MyTest.dont_trace_events!{ raise e }
    end

  end
end