module ShapeApi
  class User < Base
    # NOTE: this really performs a `find_or_create`
    custom_endpoint :create_from_emails, on: :collection, request_method: :post
  end
end
