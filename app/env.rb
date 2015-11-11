module PaperStash
  def self.root
    @root ||= File.expand_path(File.join('..', '..'), __FILE__)
  end

  def self.env
    @env ||= ActiveSupport::StringInquirer.new(ENV['PAPERSTASH_ENV'] || ENV['RACK_ENV'] || 'development')
  end

  def self.env=(new_environment)
    ENV['PAPERSTASH_ENV'] = ENV['RACK_ENV'] = new_environment
    @env = ActiveSupport::StringInquirer.new(new_environment)
  end
end
