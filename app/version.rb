module PaperStash
  def self.version
    @version ||= begin
      if PaperStash.env.production?
        File.read("#{PaperStash.root}/VERSION")
      else
        `git rev-parse HEAD`
      end
    end
  end
end
