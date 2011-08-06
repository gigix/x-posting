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
      Facebook.should_receive(:post).with('12345', {:message => message})
      Facebook.should_receive(:post).with('67890', {:message => message})
      
      post :create, :message => message
      response.should redirect_to(:action => :index)
    end
  end
  
  describe :by_user do
    it 'lists feeds of given user' do
      post :by_user, :fb_id => '12345'
      response.should be_success
    end
  end
  
  describe :by_feed do
    it 'shares feed to all profiles' do
      Facebook.should_receive(:post).with('100002722005308', 
        {:message => 'dddd', :picture => "http://external.ak.fbcdn.net/safe_image.php?d=AQAO-csscp8vwAuo&w=90&h=90&url=http%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F1%2F14%2FAnimal_diversity.png%2F275px-Animal_diversity.png", :link => "http://en.wikipedia.org/wiki/Natural_environment", :name => "Natural environment - Wikipedia, the free encyclopedia", :caption => "en.wikipedia.org", :description => "The natural environment encompasses all living and non-living things occurring naturally on Earth or some region thereof. It is an environment that encompasses the interaction of all living species.[1] The concept of the natural environment can be distinguished by components:", :icon => "http://static.ak.fbcdn.net/rsrc.php/v1/yD/r/aS8ecmYRys0.gif"})

      post :by_feed, :fb_id => '100002722005308_132666846822533'
      response.should redirect_to(:action => :index)
    end
  end
end
