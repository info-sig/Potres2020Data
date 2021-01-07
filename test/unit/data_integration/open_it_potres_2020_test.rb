require "test_helper"

module DataIntegration
  class OpenItPotres2020Test < ActiveSupport::TestCase

    def setup
      @api_host = 'https://potres2020.openit.hr/api/v3/posts/'
      self.api_exchange = []
    end

    def test_happy_path
      api_exchange << {
        response: 200,
        request_validator: lambda do |request|
          exp = {"url"=>"https://potres2020.openit.hr/api/v3/posts/", "body"=>nil, "headers"=>{}, "basic_auth"=>nil, "options"=>{}}
          act = request
          assert_equal_hashes exp, act, 'request is off'
        end
      }
      response = Transporter::FaradayHttp[@api_host, method: 'GET']
      
    end

  end
end