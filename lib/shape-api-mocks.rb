module ShapeApiMocks
  # To include these, add to your spec helper:
  #
  #   require 'shape-api-mocks'
  #
  #   RSpec.configure do |config|
  #     config.include ShapeApiMocks
  #   end
  #
  # In your tests, you can register all models that you'd like mocked
  # in before { } block, such as before { shape_api_register_double('Collection') }
  #
  # That will mock the ShapeApi::Collection class,
  # adding default return values for where/new/create methods.
  #
  # e.g.
  #
  # let(:collection_instance) { double('ShapeApi::Collection', external_id: 45) }
  #
  # before do
  #   shape_api_register_class_double('ShapeApi::Item')
  #   shape_api_register_class_double('ShapeApi::Collection',
  #                             create: collection_instance)
  # end
  #
  # it 'should return values' do
  #   expect(ShapeApi::Collection).to receive(:create).and_return(collection_instance)
  # end
  #

  def shape_api_register_double(model_name, custom_instance_doubles = {})
    klass = model_name.safe_constantize
    underscore_klass = klass.model_name.param_key

    # Check if there are custom instance attrs defined for this model,
    # otherwise use default instance attrs
    default_instance_attrs = if defined?(custom_instance_attrs)
                               send(custom_instance_attrs)
                             else
                               shape_api_default_instance_attrs(klass)
                             end

    # Define an instance double for this model
    define_singleton_method "#{underscore_klass}_instance_double" do |attrs = {}|
      double(
        model_name,
        default_instance_attrs.deep_merge(attrs || {}),
      )
    end

    # Defines method that matches lowercase class name,
    # e.g. `shape_api_collection_double`
    #
    # You can then pass params to be used for default return values
    #
    define_singleton_method "#{underscore_klass}_double" do |params = {}|
      instance_double = send("#{underscore_klass}_instance_double")

      allow(klass).to receive(:where).and_return(
        custom_instance_doubles[:where] || params[:where] || [instance_double],
      )

      allow(klass).to receive(:new).and_return(
        custom_instance_doubles[:new] || params[:new] || instance_double,
      )

      allow(klass).to receive(:create).and_return(
        custom_instance_doubles[:create] || params[:create] || instance_double,
      )
    end
  end

  # Custom Instance Attributes
  #
  # Define any models that have custom instance attribute keys
  #

  def shape_api_organization_instance_attrs
    default_api_instance_attrs(
      ShapeApi::Organization,
    ).merge(
      current_user_collection_id: 1,
    )
  end

  # Default Instance Attributes
  # These will be present on all instance doubles

  def shape_api_default_instance_attrs(klass)
    {
      id: 1,
      external_id: "My#{klass}_1",
      errors: [],
      new: true,
      save: true,
      update_attributes: true,
    }
  end
end
