class ShareController < ApplicationController
  def index
  end
  
  def create
    Profile.find(:all).each do |profile|
      Facebook.post(profile.fb_id, params[:message])
    end
    redirect_to :action => :index
  end
end
