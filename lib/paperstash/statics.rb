module PaperStash
  module Statics
    def self.server
      @server ||= begin
        not_found = Proc.new {|_| [404, {}, []]}
        Rack::Static.new(not_found, root: PaperStash.root, urls: [""])
      end
    end
  end
end
