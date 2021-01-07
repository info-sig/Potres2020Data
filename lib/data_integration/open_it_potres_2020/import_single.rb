class DataIntegration::OpenItPotres2020
  class ImportSingle
    extend ClassFunctional

    FOREIGN_SYSTEM = 'OpenItPotres2020'

    def self.mock opts = {}
      {"id"=>877,
        "url"=>"https://potres2020.openit.hr/api/v3/posts/877",
        "user"=>{"id"=>9, "url"=>"https://potres2020.openit.hr/api/v3/users/9"},
        "parent_id"=>nil,
        "form"=>{"id"=>6, "url"=>"https://potres2020.openit.hr/api/v3/forms/6"},
        "message"=>nil,
        "color"=>"#A51A1A",
        "type"=>"report",
        "title"=>"Tražimo pomoć donacija : Napravimo dobro djelo",
        "slug"=>"tražimo-pomoć-donacija-napravimo-dobro-djelo-5ff722661cb33",
        "content"=>
          "A content of various stuffs",
        "status"=>"published",
        "created"=>"2021-01-07T15:01:58+00:00",
        "updated"=>"2021-01-07T15:03:58+00:00",
        "locale"=>"en_us",
        "values"=>
          {"87e86d94-df5d-4eb5-9080-5a4d44a5f769"=>[{"lon"=>55.12345, "lat"=>33.12345}],
            "3c8441b3-5744-48bb-9d9e-d6ec4be50613"=>["Name, last name, location, IBAN of bank account for donations"],
            "4583d2a1-331a-4da2-86df-3391e152198e"=>["0981234123"]},
        "post_date"=>"2021-01-07T14:41:56+00:00",
        "tags"=>[],
        "published_to"=>[],
        "completed_stages"=>[],
        "sets"=>["2", "4"],
        "lock"=>nil,
        "source"=>nil,
        "contact"=>nil,
        "data_source_message_id"=>nil,
        "allowed_privileges"=>["read", "search"]}.
          merge(opts)
    end


    def self.call obj
      t = Ticket.where(foreign_system: FOREIGN_SYSTEM, foreign_ticket_id: obj['id']).first_or_initialize
      t.attributes = {
        title: obj['title'],
        content: obj['content'],
        status: obj['status'],

        foreign_reporting_user_id: obj.dig('user', 'id'),

        contact_phone: '',
        contact_address: '',

        contact_latitude: '',
        contact_longitude: '',

        created_at: Date.parse(obj['created']),
        updated_at: Date.parse(obj['updated']),
      }
      t.save!

      t
    end

  end
end
