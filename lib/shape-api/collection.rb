module ShapeApi
  class Collection < Base
    include ShapeApi::Resourceable

    # POST /collections/create_template
    custom_endpoint :create_template, on: :collection, request_method: :post

    # POST /collections/:id/clear_collection_cover
    custom_endpoint :clear_collection_cover, on: :member, request_method: :post

    # POST /collections/:id/restore_permissions
    custom_endpoint :restore_permissions, on: :member, request_method: :post
  end
end
