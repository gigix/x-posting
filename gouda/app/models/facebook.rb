require 'net/http'
require "net/https"
require 'uri'

class Facebook
  def self.post(profile_id, message)
    http = Net::HTTP.new('graph.facebook.com', 443)
    http.use_ssl = true

    resp, data = http.post2("#{profile_id}/feed",  
      'access_token=145634995501895|5bb93fdfb07046ed1c8bab48.1-759534364|DiQUmeetFOTdoJAe_44P7Fzj5OE' + 
      "&message=#{message}")

    return resp.body
  end
end