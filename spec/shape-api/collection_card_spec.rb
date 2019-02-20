require 'helper'

describe ShapeApi::CollectionCard do
  subject { ShapeApi::CollectionCard }

  before do
    stub_request(:post, 'https://www.shape.space/api/v1/collection_cards')
      .to_return(
        headers: { content_type: 'application/vnd.api+json' },
        status: 200,
        body: JSON.generate(
          data: { type: 'collection_cards', id: 100 },
        ),
      )
  end

  describe '#create' do
    context 'with a collection' do
      it 'should create a collection with the given name' do
        ShapeApi::CollectionCard
          .create(
            parent_id: 1,
            collection_attributes: {
              name: 'Subcollection',
            },
          )
        expect(WebMock).to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
          .with(body: json_body_including(name: 'Subcollection'))
      end
    end

    context 'with an item' do
      let(:link_url) { 'http://something.to.link/to' }

      it 'should create an item with the given name' do
        ShapeApi::CollectionCard
          .create(
            parent_id: 1,
            item_attributes: {
              name: 'My Link item',
              url: link_url,
              type: 'Item::LinkItem',
            },
          )
        expect(WebMock).to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
          .with(body: json_body_including(url: link_url))
      end
    end
  end

  describe '#create_with_text_item' do
    it 'should convert text content into quill-friendly params' do
      ShapeApi::CollectionCard
        .create_with_text_item(
          parent_id: 1,
          item_attributes: {
            name: 'My Item',
            content: 'Hello',
          },
        )
      expect(WebMock).to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
        .with(body: json_body_including(ops: [{ insert: "Hello\n" }]))
    end

    context 'with missing item_attributes' do
      it 'should return an error' do
        result = ShapeApi::CollectionCard.create_with_text_item(parent_id: 1)
        expect(result.errors.full_messages.first).to eq 'Item attributes required'
        expect(WebMock).not_to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
      end
    end
  end
end
