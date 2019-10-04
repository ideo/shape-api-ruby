require 'helper'

describe ShapeApi::Group do
  subject { ShapeApi::Group }

  describe '.manage_url' do
    it 'returns shape url with query param' do
      expect(
        ShapeApi::Group.manage_url(id: 123, org_slug: 'ideo'),
      ).to eq(
        'https://www.shape.space/ideo?manage_group_id=123',
      )
    end
  end

  describe '#manage_url' do
    let(:group) { ShapeApi::Group.new(id: 123) }

    it 'returns shape url with query param' do
      expect(group.manage_url).to eq(
        'https://www.shape.space/?manage_group_id=123',
      )

      expect(group.manage_url(org_slug: 'ideo')).to eq(
        'https://www.shape.space/ideo?manage_group_id=123',
      )
    end

    context 'with different app url' do
      before do
        ShapeApi::Base.app_url = 'https://staging.shape.space'
      end

      it 'uses specified app url' do
        expect(group.manage_url(org_slug: 'ideo')).to eq(
          'https://staging.shape.space/ideo?manage_group_id=123',
        )
      end
    end
  end
end
