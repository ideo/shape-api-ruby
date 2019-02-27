# Shape API - Ruby

Ruby wrappers for Shape API.

Master Branch: [![Codeship Status for ideo/shape-api-ruby](https://app.codeship.com/projects/632a7ff0-107e-0137-0b10-06e5032501dc/status?branch=master)](https://app.codeship.com/projects/327125)

## Installing

Add to your `Gemfile`:

```ruby
gem 'shape-api-ruby', git: 'https://github.com/ideo/shape-api-ruby.git'
```

Then `bundle install`.

## Usage

These three configuration variables must be set in an initializer (e.g. `/config/initializers/shape_api.rb`):

```
require 'shape-api'

ShapeApi::Base.configure(
  url: 'https://www.shape.space/api/v1',
  api_token: ENV['SHAPE_API_TOKEN']
)
```

Then you can use any of the supported models:

```
ShapeApi::CollectionCard
ShapeApi::Collection
ShapeApi::Group
ShapeApi::Item
ShapeApi::Organization
ShapeApi::Role
ShapeApi::User
```

To enable detailed request logging, you can set `ENV['DEBUG'] = '1'`

## Testing

We have built class and instance-level mocking methods that you can use in RSpec.

To include these, add to your spec helper:

```ruby
require 'shape-api-mocks'

RSpec.configure do |config|
  config.include ShapeApiMocks
end
```

In your tests, you can register all models that you'd like mocked in before block, such as:

```ruby
before do
  shape_api_register_double('ShapeApi::Collection')
end
```

That will mock the ShapeApi::Collection class, adding default return values for where/new/create methods. It also adds instance doubles.

For Example:

```ruby

before do
  shape_api_register_class_double('ShapeApi::Collection')
end

context 'mocking create' do
  # Uses default instance double and adds custom attribute
  let(:collection_instance) do
    shape_api_collection_instance_double(external_id: 45)
  end

  # Mocks ShapeApi::Collection and sets `create` to return instance
  before do
    shape_api_collection_double(create: collection_instance)
  end

  it 'should return values' do
    expect(
      ShapeApi::Collection
    ).to receive(:create).and_return(collection_instance)
  end
end
```
