require 'helper'

describe ShapeApi::Base do
  describe '.configure' do
    let(:shape_api_url) { 'https://www.shape.space/api/v1' }
    let(:api_token) { 'SHAPE_API_TOKEN ' }

    before do
      ShapeApi::Base.configure(
        url: shape_api_url,
        api_token: api_token,
      )
    end

    it 'sets .site' do
      expect(ShapeApi::Base.site).to eq(shape_api_url)
    end
  end
end
