module ShapeApi
  class CollectionCard < Base
    belongs_to :collection, shallow_path: true

    def self.build(parent_id:, external_id: nil, order: nil, height: 1, width: 1)
      @parent_id = parent_id
      @external_id = external_id
      @order = order
      @height = height
      @width = width
      self
    end

    def self.create_with_text_item(content:)
      text_data = { ops: [insert: "#{content}\n"] }
      create_with(
        :item,
        type: 'Item::TextItem',
        content: content,
        text_data: text_data,
      )
    end

    def self.create_with_collection(name:)
      create_with(
        :collection,
        name: name,
      )
    end

    def self.create_with(type, **attributes)
      return false unless %i[item collection].include? type

      params = {
        parent_id: @parent_id,
        external_id: @external_id,
        order: @order,
        height: @height,
        width: @width,
      }
      params["#{type}_attributes"] = attributes
      create(params)
    end
  end
end
