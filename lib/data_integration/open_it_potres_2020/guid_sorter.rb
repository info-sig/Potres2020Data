class DataIntegration::OpenItPotres2020
  class GuidSorter
    def self.known_guids
      location_guids = ["87e86d94-df5d-4eb5-9080-5a4d44a5f769", "808b965b-bbda-483a-b2fc-ab47a1b8dedf", "73c25387-b131-4396-87aa-91fcfe8a707e"]
      contact_guids = ["4583d2a1-331a-4da2-86df-3391e152198e", "565b4056-373e-4c91-9e5c-fbcd2b4f7d1a", "1328cf24-09de-44cd-b159-6242e6165530"]
      description_guids = ["3c8441b3-5744-48bb-9d9e-d6ec4be50613", "9fc48dff-6c03-4dc9-b4f3-3e22544d99f9", "17e84a96-9d98-4279-8971-e666eb5fab95"]
      conclusion_guids = ["6b541a6d-eb02-4824-8662-a741da46b2b3"]

      {
        location: location_guids,
        contact: contact_guids,
        description: description_guids,
        conclusion: conclusion_guids,
      }
    end

    def self.determine_where_guid_belongs guid
      rv = nil
      known_guids.each do |key, value|
        if known_guids[key].include? guid
          rv = key
        end
      end

      return rv
    end
  end
end
