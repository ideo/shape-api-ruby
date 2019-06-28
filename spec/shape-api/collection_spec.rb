require 'helper'

describe ShapeApi::Collection do
  subject { ShapeApi::Collection }

  describe '#url' do
    let(:collection) { ShapeApi::Collection.new(id: 25) }

    it 'returns shape url' do
      expect(collection.url).to eq(
        'https://www.shape.space/collections/25',
      )

      expect(collection.url(org_slug: 'ideo')).to eq(
        'https://www.shape.space/ideo/collections/25',
      )
    end
  end
end
