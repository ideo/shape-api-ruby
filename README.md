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
