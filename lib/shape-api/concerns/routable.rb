module ShapeApi
  module Routable
    extend ActiveSupport::Concern

    included do
      def self.url(id:, org_slug: nil)
        klass = name.split('::').last
        path = klass.downcase.pluralize

        url = ShapeApi::Base::URL
        url += "/#{org_slug}" if org_slug.present?
        "#{url}/#{path}/#{id}"
      end
    end

    def url(org_slug: nil)
      self.class.url(
        id: id,
        org_slug: org_slug,
      )
    end
  end
end
