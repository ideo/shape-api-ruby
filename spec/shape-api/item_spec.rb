require 'helper'

describe ShapeApi::Item do
  subject { ShapeApi::Item }

  describe '#shape_url' do
    let(:item) { ShapeApi::Item.new(id: 25) }

    it 'returns shape url' do
      expect(item.shape_url).to eq(
        'https://www.shape.space/items/25'
      )

      expect(item.shape_url(org_slug: 'ideo')).to eq(
        'https://www.shape.space/ideo/items/25'
      )
    end
  end

  describe '#shape_path' do
    let(:item) { ShapeApi::Item.new(id: 25) }

    it 'returns shape url' do
      expect(item.shape_path).to eq(
        '/items/25'
      )

      expect(item.shape_path(org_slug: 'ideo')).to eq(
        '/ideo/items/25'
      )
    end
  end
end
