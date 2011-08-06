#!/usr/bin/env ruby

require 'net/http'
require "net/https"
require 'uri'

http = Net::HTTP.new('graph.facebook.com', 443)
http.use_ssl = true

resp, data = http.post2('100002722005308/feed',  
  'access_token=145634995501895|5bb93fdfb07046ed1c8bab48.1-759534364|DiQUmeetFOTdoJAe_44P7Fzj5OE' + 
  "&message=post%20from%20ruby @ #{Time.now.to_f}")

puts resp.body