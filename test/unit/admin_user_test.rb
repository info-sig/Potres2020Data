require "test_helper"

class AdminUserTest < ActiveSupport::TestCase
  test "the truth" do
    api_exchange << {response: 'foo'}
    act_rv = Transporter::FaradayHttp['http://example.com/foo']
    exp_rv = {:body=>"foo", :status=>200}
    assert_equal_hashes exp_rv, act_rv
  end
end
