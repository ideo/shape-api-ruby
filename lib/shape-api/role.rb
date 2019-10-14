module ShapeApi
  class Role < Base
    # This is required for parsing Role objects from API
  end

  # All of these models are Role records,
  # but due to how json_api_client handles nested resources,
  # we must create separate models for each nested route
  class CollectionRole < Base
    belongs_to :collection, shallow_path: true

    def self.table_name
      'roles'
    end
  end

  class ItemRole < Base
    belongs_to :item, shallow_path: true

    def self.table_name
      'roles'
    end
  end

  class GroupRole < Base
    belongs_to :group, shallow_path: true

    def self.table_name
      'roles'
    end
  end

  class DatasetRole < Base
    belongs_to :dataset, shallow_path: true

    def self.table_name
      'roles'
    end
  end
end
