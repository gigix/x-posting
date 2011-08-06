require 'spec_helper'

describe ProfilesController do
  render_views
  
  describe :index do
    it 'lists all profiles' do
      get :index
      response.should be_success
      assigns[:profiles].should == Profile.find(:all)
    end
  end
  
  describe :create do
    it 'creates new profile with given fb_id and redirects' do
      lambda do
        post :create, :fb_id => '12345'
        response.should redirect_to(profiles_path)
      end.should change(Profile, :count).by(1)
      
      Profile.find(:last).fb_id.should == '12345'
    end
  end
end
