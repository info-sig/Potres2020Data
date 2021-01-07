module Transporter
  class FaradayHttp
    extend ClassFunctional

    def self.call url, options = {}
      options = options.dup
      rv = {}

      start_time = Time.now
      headers = options.delete(:headers) || {}
      timeout = options.delete(:timeout) || 30
      body = options.delete(:body)
      basic_auth = options.delete(:basic_auth)
      http_method = options.delete(:method)&.to_s&.downcase || 'post'

      development_proxy = 'http://test:8888' if options.delete(:development_proxy)
      secure_logger = options.delete(:secure_logger)

      # what's left is connection options
      connection_options = options
      connection_options.merge!(proxy: development_proxy) if development_proxy

      secure_logger&.log("Request '#{url}': \n #{body} #{options.to_yaml}")

      if InfoSig.env?(:test) && !(url.to_s =~ /localhost/)
        rv = FakerForTests[url: url, body: body, headers: headers, basic_auth: basic_auth, options: options]
        if rv.is_a?(Hash) and rv[:status]
          rv
        else
          rv = {
            body: rv,
            status: 200
          }
        end
      else
        conn = Faraday::Connection.new url, connection_options
        conn.basic_auth *basic_auth if basic_auth
        conn.response :logger, ::Logger.new(STDOUT) if InfoSig.env?(:development)

        response = conn.send(http_method) do |req|
          req.options[:timeout]      = timeout
          req.options[:open_timeout] = timeout

          req.headers = (req.headers || {}).merge headers
          req.body = body if body
        end

        rv = {
          body: response.env.body,
          status: response.env.body
        }
        binding.pry
      end
      secure_logger&.log("Response: \n#{rv}")
      rv

    rescue Exception => e # handle exceptions quietly
      raise e
    ensure
      @time_spent = Time.now - start_time
    end
  end
end
