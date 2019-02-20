module ShapeApi
  class CollectionCard < Base
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
