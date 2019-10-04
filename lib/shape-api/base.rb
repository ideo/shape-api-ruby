# Base resource for models on Shape API

require 'securerandom'

module ShapeApi
  class Base < ::JsonApiClient::Resource
    APP_URL = 'https://www.shape.space'.freeze
    API_URL = APP_URL + '/api/v1'.freeze

    class_attribute :api_token, :app_url

    # There is a bug with included resources where ID is cast as an integer,
    # and then the resource can't be auto-linked
    property :id, type: :string
    property :number, type: :float

    def self.configure(api_token:, api_url: API_URL, app_url: APP_URL)
      self.api_token = api_token
      self.site = api_url
      self.app_url = app_url

      # Sets up connection with token
      connection do |connection|
        # Set Api Token header
        connection.use FaradayMiddleware::OAuth2,
                       Base.api_token,
                       token_type: 'bearer'

        # Log requests if DEBUG == '1'
        if defined?(Rails) == 'constant' && ENV['DEBUG'] == '1'
          connection.use Faraday::Response::Logger
        end
      end
    end

    # Version 1.5.3 doesn't properly parse out relationships
    # (the keys are ints, so it doesn't match them)
    def included_relationship_json(name)
      return if relationships[name].blank? ||
                relationships[name]['data'].blank?

      type = relationships[name]['data']['type']
      id = relationships[name]['data']['id']
      included_data = last_result_set.included.data[type]
      return if included_data.blank?

      included_data[id.to_i] || included_data[id.to_s]
    end
  end
end
