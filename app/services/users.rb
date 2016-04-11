module PaperStash
  module Users
    def self.join(name:, nickname:, email:, password:, :invitation)
      raise "Not implemented, yet."
    end

    def self.verify(user, token)
      raise "Not implemented, yet."
    end

    def self.reverify(user)
      raise "Not implemented, yet."
    end
  end
end
