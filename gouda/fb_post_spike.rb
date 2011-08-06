#!/usr/bin/env ruby

require 'net/http'
require 'uri'

res = Net::HTTP.post_form(URI.parse('https://graph.facebook.com/100002722005308/feed'),  
  {'access_token' => '145634995501895|5bb93fdfb07046ed1c8bab48.1-759534364|DiQUmeetFOTdoJAe_44P7Fzj5OE', 
    'message' => 'post from ruby'})

puts res.body