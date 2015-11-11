module PaperStash
  module Database
    def self.connect!
      url = URI.parse(PaperStash.config.database.url)
      @connection = Sequel.postgres(:user => url.user,
                                    :password => url.password,
                                    :host => url.host,
                                    :port => url.port,
                                    :database => url.path[1..-1],
                                    :test => true,
                                    :sslmode => :prefer,
                                    :max_connections => PaperStash.config.database.pool.size)
      PaperStash::Model.db = @connection
      @connection
    end

    def self.disconnect!
      @connection.disconnect
      @connection = nil
    end

    def self.connection
      @connection
    end

    def self.migrate(connection)
      Sequel::IntegerMigrator.run(connection, "#{PaperStash.root}/db/migrations")
    end

    def self.seed(connection)
      # TODO(mtwilliams): Implement seeding.
    end
  end
end
