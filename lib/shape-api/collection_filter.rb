module ShapeApi
  class CollectionFilter < Base
    belongs_to :collection, shallow_path: true

    # POST /collection_filters/:id/select
    custom_endpoint :select, on: :member, request_method: :post

    # POST /collection_filters/:id/unselect
    custom_endpoint :unselect, on: :member, request_method: :post
  end
end
