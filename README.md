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

## Roles

The `.allowed_roles` class methods on `ShapeApi::Group`,
`ShapeApi::Collection` and `ShapeApi::Item` returns an array of
allowed roles for each model type.

The `create_role` and `delete_role` methods are available on `ShapeApi::Collection` and `ShapeApi::Item`, and allow you to add/remove roles from those resources

```
create_role(role_name, params = {})

delete_role(role_name, params = {})

Available params for both methods:
- [user_ids] - array of Shape user ids to add/remove
- [group_ids] - array of Shape group ids to add/remove
- is_switching - boolean - if user is merely switching roles rather than a new role
    - default true
- send_invites - boolean - send invitations to users (only applicable when creating a new role)
   - default true
```

If you call create_role and send_invites for user(s) that were
already added to the resource, they will still get an email
invitation (it doesn't care that they already had access).

Examples:

```
collection.create_role(:editor, { group_ids: [45]})

item.delete_role(:editor, { user_ids: [92]})
```

## Url Helpers

Some models have url helpers that generate Shape front-end urls.

`ShapeApi::Group` has a class method to generate the group manage url (opens the group manage modal):

```
ShapeApi::Group.manage_url(id: 987, org_slug: 'mitsui')
'https://www.shape.space/mitsui?manage_group_id=987'
```

There is also a corresponding instance method:

```
group.manage_url(org_slug: 'mitsui')
'https://www.shape.space/mitsui?manage_group_id=987'
```

`ShapeApi::Collection` and `ShapeApi::Item` also have `url` instance methods:

```
collection.url(org_slug: 'ford')
'https://www.shape.space/ford/collections/123'

collection.url(org_slug: 'ford')
'https://www.shape.space/ford/collections/123'
```

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
