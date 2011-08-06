require 'spec_helper'

describe ShareController do
  render_views
  
  describe :index do
    it 'renders a form to allow user to input message' do
      post :index
      response.should be_success
    end
  end
end
