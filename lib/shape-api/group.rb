module ShapeApi
  class Group < Base
    include ShapeApi::Resourceable
    belongs_to :organization, shallow_path: true

    # PATCH /groups/:id/archive
    custom_endpoint :archive, on: :member, request_method: :patch

    # NOTE: `create` method can take `organization_id` and `external_id`
    # `handle` also needs to be unique, we don't currently generate a unique one for you :(

    def self.manage_url(id: nil, org_slug: nil)
      "#{ShapeApi::Base.app_url}/#{org_slug ? org_slug : nil}?manage_group_id=#{id}"
    end

    def manage_url(org_slug: nil)
      self.class.manage_url(id: id, org_slug: org_slug)
    end
  end
end
