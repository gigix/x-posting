require 'net/http'
require "net/https"
require 'uri'

require 'json'

class Facebook
  def self.post(profile_id, options)
    http = http_to_fb
    resp, data = http.post2("#{profile_id}/feed", "access_token=#{access_token}&" + to_query_string(options))
    return resp.body
  end

  def self.fetch_single_feed(feed_id)
    feed_json = ""
    
    if(Rails.env == 'production')
      feed_json = actual_fetch_single_feed(feed_id)
    else
      feed_json = File.open("#{Rails.root}/spec/fixtures/single_feed.json"){|f| f.read}
    end
    
    JSON.parse(feed_json)['data'][0]
  end

  def self.fetch_feeds(profile_id)
    feeds_json = ""
    
    if(Rails.env == 'production')
      feeds_json = actual_fetch_feeds(profile_id)
    else
      feeds_json = fetch_fake_feeds
    end
    
    JSON.parse(feeds_json)['data']
  end
  
  private
  def self.to_query_string(hash)
    hash.map{|k, v| "#{k}=#{v}"}.join("&")
  end
  
  def self.fetch_fake_feeds
    File.open("#{Rails.root}/spec/fixtures/user_feeds.json"){|f| f.read}
  end
  
  def self.actual_fetch_feeds(profile_id)
    http = http_to_fb
    resp, data = http.get2("#{profile_id}/feed?access_token=#{access_token}")
    return resp.body
  end
  
  def self.actual_fetch_single_feed(feed_id)
    http = http_to_fb
    resp, data = http.get2("#{feed_id}?access_token=#{access_token}")
    return resp.body
  end
  
  def self.http_to_fb
    http = Net::HTTP.new('graph.facebook.com', 443)
    http.use_ssl = true
    http
  end
  
  def self.access_token
    "145634995501895|5bb93fdfb07046ed1c8bab48.1-759534364|DiQUmeetFOTdoJAe_44P7Fzj5OE"
  end
end