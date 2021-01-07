module DataIntegration
  class OpenItPotres2020

    attr_accessor :opts

    def initialize opts = {}
      @opts = {}
      @api_host = opts[:api_host] || 'https://potres2020.openit.hr/api/v3/posts/'
    end

    def log_in
      # TODO
    end

    def fetch_cases
      response = Transporter::FaradayHttp[@api_host, method: 'GET']
      JSON.parse(response[:body])['results']
    end

    def fetch_case idx, options = {}
      # If body is already parsed, like in fetch_cases method, it can be passed as optional argument
      # fetch_case(50, parsed_body: body)
      #
      # Otherwise it API call will be made to retrieve specific case
      if options[:parsed_body]
        parsed_case = options[:parsed_body].select { |record| record["id"] == idx }.first
      else
        url = @api_host + "#{idx}"
        response = Transporter::FaradayHttp[url, method: 'GET']
        parsed_case = JSON.parse(response[:body])
      end

      return if parsed_case == nil
      parsed_case = parsed_case.with_indifferent_access
      user_id = parsed_case[:user] ? parsed_case[:user][:id] : parsed_case[:user_id]

      post = {
        post_id: parsed_case[:id],
        user_id: user_id,
        form_id: parsed_case[:form][:id],
        type: parsed_case[:type],
        title: parsed_case[:title],
        content: parsed_case[:content],
        status: parsed_case[:status],
        created: parsed_case[:created],
        updated: parsed_case[:updated],
        values: parsed_case[:values]
      }

      post.merge!(parse_additional_values(parsed_case[:values]))
    end

    private

    def parse_additional_values values
      rv_hash = {}
      values.each do |key, value|
        guid_alias = DataIntegration::GuidSorter.determine_where_guid_belongs(key)
        if guid_alias != nil
          rv_hash.merge!({ guid_alias => value[0] })
        end
      end

      rv_hash
    end

  end
end