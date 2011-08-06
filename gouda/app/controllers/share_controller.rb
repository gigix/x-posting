class ShareController < ApplicationController
  protect_from_forgery :except => :index
  
  def index
  end
  
  def create
    Profile.find(:all).each do |profile|
      Facebook.post(profile.fb_id, params[:message])
    end
    redirect_to :action => :index
  end
end
