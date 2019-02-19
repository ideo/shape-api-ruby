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

  describe '#create_with' do
    it 'should return a successful result' do
      result = ShapeApi::CollectionCard
               .create_with_text_item(
                 content: 'Hello',
                 card_attributes: {
                   parent_id: 3, order: 2
                 },
               )
      expect(result.persisted?).to be true
      expect(result.errors.messages).to be_empty
    end

    it 'should use collection_card variables added in build method' do
      ShapeApi::CollectionCard
        .create_with_text_item(
          content: 'Hello',
          card_attributes: {
            parent_id: 3, external_id: 99, order: 2
          },
        )
      expect(WebMock).to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
        .with(body: json_body_including(parent_id: 3, order: 2))
    end

    it 'should include external_id in collection_card params' do
      ShapeApi::CollectionCard
        .create_with_text_item(
          content: 'Hello',
          card_attributes: {
            parent_id: 3, external_id: 99, order: 2
          },
        )
      expect(WebMock).to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
        .with(body: json_body_including(parent_id: 3, order: 2, external_id: 99))
    end

    context 'with errors' do
      before do
        stub_request(:post, 'https://www.shape.space/api/v1/collection_cards')
          .to_return(
            headers: { content_type: 'application/vnd.api+json' },
            status: 422,
            body: JSON.generate(
              errors: [{ external_id: 'error msg' }],
            ),
          )
      end

      it 'should include external_id in collection_card params' do
        result = ShapeApi::CollectionCard
                 .create_with_text_item(
                   content: 'Hello',
                   card_attributes: {
                     parent_id: 3, external_id: 99, order: 2
                   },
                 )

        expect(result.persisted?).to be false
        expect(result.errors.messages).not_to be_empty
      end
    end
  end

  describe '#create_with_text_item' do
    it 'should convert text content into quill-friendly params' do
      ShapeApi::CollectionCard
        .create_with_text_item(
          content: 'Hello',
          card_attributes: {
            parent_id: 1,
          }
        )
      expect(WebMock).to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
        .with(body: json_body_including(ops: [{ insert: "Hello\n" }]))
    end
  end

  describe '#create_with_collection' do
    it 'should create a collection with the given name' do
      ShapeApi::CollectionCard
        .create_with_collection(
          name: 'Subcollection',
          card_attributes: {
            parent_id: 1,
          }
        )
      expect(WebMock).to have_requested(:post, 'https://www.shape.space/api/v1/collection_cards')
        .with(body: json_body_including(name: 'Subcollection'))
    end
  end
end
