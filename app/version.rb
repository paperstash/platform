module PaperStash
  def self.version
    # We don't have access to the Git repository (in Docker).
    @version ||= ENV['PAPERSTASH_VERSION'] | File.read("#{PaperStash.root}/VERSION")
  end
end
