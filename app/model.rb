module PaperStash
  Model = Class.new(Sequel::Model)

  # Stop Sequel from bitching if it's subclassed before the first database
  # connection is established.
  Model.db = Sequel.mock if Sequel::DATABASES.empty?

  class Model
    def self::db=(db)
      self.descendents.each do |subclass|
        subclass.db = PaperStash::Database.connection
      end
    end
  end
end
