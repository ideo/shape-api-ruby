module ShapeApi
  class Organization < Base
    # switch context to this org for subsequent requests
    def use
      ShapeApi::User.requestor.custom(
        'switch_org',
        { request_method: :post },
        organization_id: id,
      )
    end
  end
end
