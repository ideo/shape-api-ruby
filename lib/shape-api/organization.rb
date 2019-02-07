module ShapeApi
  class Organization < Base
    def self.find_by_external_id(external_id)
      where(
        external_id: external_id
      ).first
    end
  end
end
