require 'json_api_client'

if defined?(ActiveSupport) == 'constant'
  # Use correct page parameters for Network API
  # (only works when included in Rails environment)
  JsonApiClient::Paginating::Paginator.page_param = 'number'
  JsonApiClient::Paginating::Paginator.per_page_param = 'size'
end

require 'shape-api/version'
require 'shape-api/base'

require 'shape-api/concerns/resourceable'
require 'shape-api/application_organization'
require 'shape-api/application'
require 'shape-api/collection_card'
require 'shape-api/collection'
require 'shape-api/filestack_file'
require 'shape-api/group'
require 'shape-api/item'
require 'shape-api/organization'
require 'shape-api/role'
require 'shape-api/user'
