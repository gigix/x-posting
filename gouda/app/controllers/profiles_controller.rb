class ProfilesController < ApplicationController
  def index
    @profiles = Profile.find(:all)
  end  
  
  def create
    Profile.create!(:fb_id => params[:fb_id])
    redirect_to profiles_path
  end
end
