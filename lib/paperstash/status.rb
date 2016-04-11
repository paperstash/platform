module PaperStash
  class Status
    def initialize(_opts)
      @@ip ||= Net::HTTP.get(URI("https://api.ipify.org")).trim
      @@host ||= Socket.gethostname.strip
      if PaperStash.env.development?
        @@version ||= `git rev-parse HEAD`.strip
      else
        @@version ||= ENV['SOURCE_VERSION']
      end
    end

    def call(env)
      [200, {'Content-Type' => 'application/json'}, [{
        status: 'healthy',
        ip: @@ip,
        host: @@host,
        time: Time.now.to_i,
        version: @@version,
        meaning_of_life: 42
      }.to_json]]
    end
  end
end
