require 'helper'

describe ShapeApi::Item do
  subject { ShapeApi::Item }

  describe '#url' do
    let(:collection) { ShapeApi::Item.new(id: 25) }

    it 'returns shape url' do
      expect(collection.url).to eq(
        'https://www.shape.space/items/25'
      )

      expect(collection.url(org_slug: 'ideo')).to eq(
        'https://www.shape.space/ideo/items/25'
      )
    end
  end
end
