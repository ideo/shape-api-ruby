module ShapeApi
  class CollectionCard < Base
    def self.build(attributes: {}, item_attributes: {}, collection_attributes: {})
      params = {
        order: 0,
        height: 1,
        width: 1,
      }.merge(attributes)
      params[:item_attributes] = item_attributes if item_attributes.present?
      params[:collection_attributes] = collection_attributes if collection_attributes.present?
      new(params)
    end

    def self.create_with_text_item(content:, card_attributes: {})
      text_data = { ops: [insert: "#{content}\n"] }
      card = build(
        attributes: card_attributes,
        item_attributes: {
          type: 'Item::TextItem',
          content: content,
          text_data: text_data,
        },
      )
      card.save
      card
    end

    def self.create_with_collection(name:, card_attributes: {})
      card = build(
        attributes: card_attributes,
        collection_attributes: {
          name: name,
        },
      )
      card.save
      card
    end
  end
end
