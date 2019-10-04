require 'helper'

describe ShapeApi::Base do
  describe '.configure' do
    let(:shape_api_url) { 'https://api.shape.space/api/v1' }
    let(:shape_app_url) { 'https://www.shape.space' }
    let(:api_token) { 'SHAPE_API_TOKEN ' }

    before do
      ShapeApi::Base.configure(
        api_url: shape_api_url,
        app_url: shape_app_url,
        api_token: api_token,
      )
    end

    it 'sets .site' do
      expect(ShapeApi::Base.site).to eq(shape_api_url)
    end

    it 'sets .app_url' do
      expect(ShapeApi::Base.app_url).to eq(shape_app_url)
    end
  end
end
