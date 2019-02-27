require 'helper'
require 'shape-api-mocks'

describe Class do
  include ShapeApiMocks

  it 'lets you register doubles' do
    expect(respond_to?('shape_api_item_double')).to be false
    shape_api_register_double('ShapeApi::Item')
    expect(respond_to?('shape_api_item_double')).to be true
  end

  it 'lets you assert expectations against the doubles' do
    expect(respond_to?('shape_api_item_instance_double')).to be false
    shape_api_register_double('ShapeApi::Item')
    expect(respond_to?('shape_api_item_instance_double')).to be true
    expect(ShapeApi::Item).to receive(:create).and_return(
      shape_api_item_instance_double,
    )
    ShapeApi::Item.create({})
  end

  context 'with custom doubles provided' do
    let(:custom_double) { double('ShapeApi::Item', external_id: 456) }
    before do
      shape_api_register_double('ShapeApi::Item', create: custom_double)
    end

    it 'returns custom doubles' do
      expect(ShapeApi::Item).to receive(:create).and_return(
        custom_double,
      )
      ShapeApi::Item.create({})
    end
  end
end
