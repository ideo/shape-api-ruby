module ShapeApi
  class Item < Base
    include ShapeApi::Resourceable
    include ShapeApi::Routable

    # PATCH /items/:id/archive
    custom_endpoint :archive, on: :member, request_method: :patch
  end
end
