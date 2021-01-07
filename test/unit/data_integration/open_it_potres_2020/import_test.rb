require "test_helper"

class DataIntegration::OpenItPotres2020
  class ImportTest < ActiveSupport::TestCase

    ImportSingle = DataIntegration::OpenItPotres2020::ImportSingle

    def test_import_single_should_work
      act_rv = ImportSingle[ImportSingle.mock].attributes
      exp_rv = {"id"=>"fa89ecb7-a8ef-4938-b8ba-05d06c5f2aa7",
        "title"=>"Tražimo pomoć donacija : Napravimo dobro djelo",
        "content"=>"A content of various stuffs",
        "status"=>"published",
        "foreign_system"=>"OpenItPotres2020",
        "foreign_ticket_id"=>"877",
        "foreign_reporting_user_id"=>"9",
        "contact_phone"=>"",
        "contact_address"=>"",
        "contact_latitude"=>nil,
        "contact_longitude"=>nil,
        "version"=>nil,
        "created_at"=>Date.parse("Thu, 07 Jan 2021 00:00:00.000000000 UTC +00:00"),
        "updated_at"=>Date.parse("Thu, 07 Jan 2021 00:00:00.000000000 UTC +00:00")}

      assert_equal_hashes exp_rv, act_rv, 'imported object looks funny',
        except: 'id'
    end

  end
end