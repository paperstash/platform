require 'net/http'
require 'digest/md5'

module Gravatar
  def self.for(email)
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
  end

  def self.exists?(email)
    http = Net::HTTP.start("gravatar.com", 80, :open_timeout => 1, :read_timeout => 1)
    http.head("#{Gravatar.for(email.downcase)}?default=404").code.to_i == 200
  rescue Exception => _
    false
  end
end
