require 'net/http'
require "net/https"
require 'uri'

require 'json'

class Facebook
  def self.post(profile_id, options)
    http = http_to_fb
    resp, data = http.post2("#{profile_id}/feed", "access_token=#{access_token}&" + to_query_string(options))
    
    case resp
    when Net::HTTPSuccess, Net::HTTPRedirection
      # OK
    else
      raise to_query_string(options)
    end
    
    return resp.body
  end

  def self.fetch_single_feed(feed_id)
    feed_json = ""
    
    if(Rails.env == 'production')
      feed_json = actual_fetch("#{feed_id}?access_token=#{access_token}")
    else
      feed_json = File.open("#{Rails.root}/spec/fixtures/single_feed.json"){|f| f.read}
    end
    
    JSON.parse(feed_json)
  end

  def self.fetch_feeds(profile_id)
    feeds_json = ""
    
    if(Rails.env == 'production')
      feeds_json = actual_fetch("#{profile_id}/feed?access_token=#{access_token}")
    else
      feeds_json = fetch_fake_feeds
    end
    
    JSON.parse(feeds_json)['data']
  end
  
  private
  def self.http_to_fb
    http = Net::HTTP.new('graph.facebook.com', 443)
    http.use_ssl = true
    http
  end
  
  def self.to_query_string(hash)
    hash.map{|k, v| "#{k}=#{ERB::Util.u(v)}"}.join("&")
  end
  
  def self.fetch_fake_feeds
    File.open("#{Rails.root}/spec/fixtures/user_feeds.json"){|f| f.read}
  end
  
  def self.actual_fetch(uri)
    url = %Q("https://graph.facebook.com/#{uri}")
    output_file = "#{Rails.root}/tmp/#{rand(Time.now.to_f)}.tmp"
    cmd = "wget #{url} -O #{output_file}"
    puts cmd
    raise "Fetch failed with <#{cmd}>" unless system(cmd)
    File.open(output_file){|f| f.read}
  end
  
  def self.access_token
    "145634995501895|5bb93fdfb07046ed1c8bab48.1-759534364|DiQUmeetFOTdoJAe_44P7Fzj5OE"
  end
end