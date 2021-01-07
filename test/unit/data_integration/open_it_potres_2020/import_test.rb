require "test_helper"

class DataIntegration::OpenItPotres2020
  class ImportTest < ActiveSupport::TestCase

    ImportSingle = DataIntegration::OpenItPotres2020::ImportSingle

    def test_import_single_should_work
      t = ImportSingle[ImportSingle.mock]

      act_rv = t.attributes
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

      assert_equal_hashes exp_rv, act_rv, 'imported object Ticket object looks funny',
        except: 'id'

      act_rv = t.foreign_from('OpenItPotres2020', instantiate: true).attributes
      exp_rv = {"foreign_system"=>"OpenItPotres2020", "foreign_ticket_id"=>"877", "foreign_url"=>"https://potres2020.openit.hr/api/v3/posts/877", "payload"=>{"id"=>877, "url"=>"https://potres2020.openit.hr/api/v3/posts/877", "user"=>{"id"=>9, "url"=>"https://potres2020.openit.hr/api/v3/users/9"}, "parent_id"=>nil, "form"=>{"id"=>6, "url"=>"https://potres2020.openit.hr/api/v3/forms/6"}, "message"=>nil, "color"=>"#A51A1A", "type"=>"report", "title"=>"Tražimo pomoć donacija : Napravimo dobro djelo", "slug"=>"tražimo-pomoć-donacija-napravimo-dobro-djelo-5ff722661cb33", "content"=>"A content of various stuffs", "status"=>"published", "created"=>"2021-01-07T15:01:58+00:00", "updated"=>"2021-01-07T15:03:58+00:00", "locale"=>"en_us", "values"=>{"87e86d94-df5d-4eb5-9080-5a4d44a5f769"=>[{"lon"=>55.12345, "lat"=>33.12345}], "3c8441b3-5744-48bb-9d9e-d6ec4be50613"=>["Name, last name, location, IBAN of bank account for donations"], "4583d2a1-331a-4da2-86df-3391e152198e"=>["0981234123"]}, "post_date"=>"2021-01-07T14:41:56+00:00", "tags"=>[], "published_to"=>[], "completed_stages"=>[], "sets"=>["2", "4"], "lock"=>nil, "source"=>nil, "contact"=>nil, "data_source_message_id"=>nil, "allowed_privileges"=>["read", "search"]}, "created_at"=>Date.parse('Thu, 07 Jan 2021 00:00:00.000000000 UTC +00:00'), "updated_at"=>Date.parse('Thu, 07 Jan 2021 00:00:00.000000000 UTC +00:00')}

      assert_equal_hashes exp_rv, act_rv, 'imported object Ticket object looks funny',
        except: ['id', 'ticket_id']
    end

  end
end