module Rails

  def self.heroku?
    ::Rails.env.production? && ENV['HEROKU_HOST']
  end

  def self.travis?
    ENV['TRAVIS']
  end

  def self.https_enforced?
    ::Rails.env.production? && ENV['HOST_URL'].to_s =~ /^https/
  end

  def self.development_system?
    !::Rails.env.production? || !!ENV['DEVELOPMENT_SYSTEM']
  end

  def self.env?(arg)
    Rails.env.send("#{arg}?")
  end

  def self.host_url
    @host_url ||= ENV['HOST_URL'] || 'http://localhost:3000'
  end

  def self.host_uri
    @host_uri ||= URI.parse host_url
  end

end
InfoSig = ::Rails