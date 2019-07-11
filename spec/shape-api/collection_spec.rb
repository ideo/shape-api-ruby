require 'helper'

describe ShapeApi::Collection do
  subject { ShapeApi::Collection }

  describe '#shape_url' do
    let(:collection) { ShapeApi::Collection.new(id: 25) }

    it 'returns shape url' do
      expect(collection.shape_url).to eq(
        'https://www.shape.space/collections/25',
      )

      expect(collection.shape_url(org_slug: 'ideo')).to eq(
        'https://www.shape.space/ideo/collections/25',
      )
    end
  end

  describe '#shape_path' do
    let(:collection) { ShapeApi::Collection.new(id: 25) }

    it 'returns shape path' do
      expect(collection.shape_path).to eq(
        '/collections/25',
      )

      expect(collection.shape_path(org_slug: 'ideo')).to eq(
        '/ideo/collections/25',
      )
    end
  end
end
