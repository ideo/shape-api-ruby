module ShapeApi
  class Item < Base
    include ShapeApi::Resourceable
    include ShapeApi::Routable
  end
end
