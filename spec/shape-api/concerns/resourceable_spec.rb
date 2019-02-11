require 'helper'

describe ShapeApi::Resourceable, type: :concern do
  it 'should have concern included' do
    expect(ShapeApi::Group.ancestors).to include(ShapeApi::Resourceable)
    expect(ShapeApi::Item.ancestors).to include(ShapeApi::Resourceable)
    expect(ShapeApi::Collection.ancestors).to include(ShapeApi::Resourceable)
  end

  let(:collection) { ShapeApi::Collection.new(id: 1) }
  let(:api_url) { 'https://www.shape.space/api/v1/collections/1/roles' }

  describe '#create_role' do
    before do
      stub_request(:post, api_url)
    end

    it 'should call roles API method of resource with assignment params' do
      collection.create_role(:viewer, user_ids: [1, 2, 3])
      expect(WebMock).to have_requested(:post, api_url)
    end
  end

  describe '#delete_role' do
    let(:delete_url) { "#{api_url}?_jsonapi%5Brole%5D%5Bname%5D=viewer&_jsonapi%5Buser_ids%5D%5B0%5D=1" }

    before do
      stub_request(:delete, delete_url)
    end

    it 'should call roles API method of resource with delete role params' do
      collection.delete_role(:viewer, user_ids: [1])
      expect(WebMock).to have_requested(:delete, delete_url)
    end
  end
end
