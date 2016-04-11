module PaperStash
  def self.env
    env = (ENV['PAPERSTASH_ENV'] || ENV['RACK_ENV'] || 'development')
    @env ||= env.inquiry
  end

  def self.root
    @root ||= File.join(File.dirname(__FILE__), '..', '..')
  end
end
