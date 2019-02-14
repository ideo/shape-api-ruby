module ShapeApi
  class Group < Base
    include ShapeApi::Resourceable
    belongs_to :organization, shallow_path: true

    # NOTE: `create` method can take `organization_id` and `external_id`
    # `handle` also needs to be unique, we don't currently generate a unique one for you :(
  end
end
