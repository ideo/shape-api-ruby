module ShapeApi
  module Routable
    extend ActiveSupport::Concern

    included do
      def self.shape_url(id:, org_slug: nil)
        ShapeApi::Base::URL + shape_path(id: id, org_slug: org_slug)
      end

      def self.shape_path(id:, org_slug: nil)
        klass = name.split('::').last
        object_type = klass.downcase.pluralize
        '/' + [org_slug, object_type, id].compact.join('/')
      end
    end

    def shape_url(org_slug: nil)
      self.class.shape_url(
        id: id,
        org_slug: org_slug,
      )
    end

    def shape_path(org_slug: nil)
      self.class.shape_path(
        id: id,
        org_slug: org_slug,
      )
    end
  end
end
