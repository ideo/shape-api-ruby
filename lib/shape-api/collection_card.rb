module ShapeApi
  class CollectionCard < Base
    # POST /collection_cards/move
    custom_endpoint :move, on: :collection, request_method: :post

    # POST /collection_cards/duplicate
    custom_endpoint :duplicate, on: :collection, request_method: :post

    # POST /collection_cards/link
    custom_endpoint :link, on: :collection, request_method: :post

    # PATCH /collection_cards/:id/archive
    custom_endpoint :archive, on: :collection, request_method: :patch

    # PATCH /collection_cards/:id/unarchive
    custom_endpoint :unarchive, on: :collection, request_method: :patch

    def self.create_with_text_item(**params)
      unless params[:item_attributes].present?
        card = new
        card.errors.add(:item_attributes, 'required')
        return card
      end

      params[:item_attributes][:type] ||= 'Item::TextItem'
      content = params[:item_attributes][:content]
      if content.present?
        params[:item_attributes][:data_content] = {
          ops: [insert: "#{content}\n"],
        }
      end
      create(params)
    end
  end
end
