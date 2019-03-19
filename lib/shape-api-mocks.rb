module ShapeApiMocks
  # To include these, add to your spec helper:
  #
  #   require 'shape-api-mocks'
  #
  #   RSpec.configure do |config|
  #     config.include ShapeApiMocks
  #   end
  #
  # See the README for usage details
  #

  def shape_api_register_double(model_name, custom_instance_doubles = {})
    klass = model_name.safe_constantize
    underscore_klass = klass.model_name.param_key

    # Define an instance double for this model
    #
    define_singleton_method "#{underscore_klass}_instance_double" do |attrs = {}|
      default_instance_attrs = shape_api_default_instance_attrs(klass)
      double(
        model_name,
        default_instance_attrs.deep_merge(attrs || {}),
      )
    end

    # Define class dobule that matches lowercase class name,
    # e.g. `shape_api_collection_double`
    #
    # You can then pass params to be used for default return values
    #
    define_singleton_method "#{underscore_klass}_double" do |params = {}|
      instance_double = send("#{underscore_klass}_instance_double")

      allow(klass).to receive(:where).and_return(
        custom_instance_doubles[:where] || params[:where] || [instance_double],
      )

      allow(klass).to receive(:find).and_return(
        custom_instance_doubles[:find] || params[:find] || [instance_double],
      )

      allow(klass).to receive(:new).and_return(
        custom_instance_doubles[:new] || params[:new] || instance_double,
      )

      allow(klass).to receive(:create).and_return(
        custom_instance_doubles[:create] || params[:create] || instance_double,
      )
    end

    # Call class methods so they are mocked
    send("#{underscore_klass}_double")
  end

  # Default Instance Attributes
  # These will be present on all instance doubles

  def shape_api_default_instance_attrs(klass)
    {
      id: 1,
      external_id: "My#{klass}_1",
      errors: double(
        :[] => [],
        empty?: true,
        full_messages: [],
      ),
      new: true,
      save: true,
      update_attributes: true,
    }
  end
end
