require 'spec_helper'

describe ShareController do
  render_views
  
  describe :index do
    it 'renders a form to allow user to input message' do
      post :index
      response.should be_success
    end
  end
  
  describe :create do
    it 'sends message to all profiles' do
      Profile.create!(:fb_id => '12345')
      Profile.create!(:fb_id => '67890')
      
      message = "Hello~"
      Facebook.should_receive(:post).with('12345', message)
      Facebook.should_receive(:post).with('67890', message)
      
      post :create, :message => message
      response.should redirect_to(:action => :index)
    end
  end
end
