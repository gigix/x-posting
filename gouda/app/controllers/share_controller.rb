class ShareController < ApplicationController
  protect_from_forgery :except => :index
  
  def index
  end
  
  def create
    Profile.find(:all).each do |profile|
      Facebook.post(profile.fb_id, {:message => params[:message]})
    end
    redirect_to :action => :index
  end
  
  def by_user
    @feeds = Facebook.fetch_feeds(params[:fb_id])
  end
  
  def by_feed
    feed = Facebook.fetch_single_feed(params[:fb_id])
    
    post_options = {:message => feed['message'], :picture => feed['picture'], :link => feed['link'], 
      :name => feed['name'], :caption => feed['caption'], :description => feed['description'], 
      :icon => feed['icon']}
    
    Facebook.post(feed['from']['id'], post_options)
    redirect_to :action => :index
  end
end
