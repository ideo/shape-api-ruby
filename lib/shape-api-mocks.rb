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

  def shape_api_register_instance_double(model_name, class_doubles = :all_class_doubles)
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

    class_doubles = {} if class_doubles == :all_class_doubles

    return unless class_doubles.is_a?(Hash)

    shape_api_register_class_doubles(model_name, class_doubles)
  end

  def shape_api_register_class_doubles(model_name, default_params)
    klass = model_name.safe_constantize
    underscore_klass = klass.model_name.param_key
    # Define class dobule that matches lowercase class name,
    # e.g. `shape_api_collection_double`
    #
    # You can then pass params to be used for default return values
    #
    define_singleton_method "#{underscore_klass}_double" do |params = {}|
      instance_double = send("#{underscore_klass}_instance_double")

      singular_methods = %i[new create]

      %i[where find new create].each do |method|
        # Pass in a proc if you'd like to handle the stub with custom response values
        if default_params[method].is_a?(Proc) || params[method].is_a?(Proc)
          allow(klass).to receive(method) do |args|
            params[method]&.call(args) ||
              default_params[method].call(args)
          end
        else
          return_value = params[method] || default_params[method]
          return_value ||= singular_methods.include?(method) ? instance_double : [instance_double]

          allow(klass).to receive(method).and_return(return_value)
        end
      end
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
