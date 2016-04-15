require File.expand_path '../spec_helper', __FILE__

describe 'My Movie Quiz app' do
  describe 'index page' do
    it 'gives status 200' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'renders index page' do
      get '/'
      expect(last_response.body.downcase).to include('movie lovers')
    end
  end
end
