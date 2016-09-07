# NestedAttributesSerializer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nested_attributes_serializer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nested_attributes_serializer

## Usage

```ruby
class Search < ApplicationRecord
  include NestedAttributesSerializer

  has_many :queries

  accepts_nested_attributes_for :queries
end
```

```ruby
class Query < ApplicationRecord
  belongs_to :search
end
```

```ruby
search = Search.new(queries_attributes: [{query: "foo"}, {query: "bar"}])
search.queries
# [
#   #<Query:0x000000043e02e8 id: nil, query: "foo", created_at: nil, updated_at: nil, search_id: nil>,
#   #<Query:0x000000043cdd00 id: nil, query: "bar", created_at: nil, updated_at: nil, search_id: nil>
# ]

serialized_search = search.to_nested_attributes(include: :queries)
# {
#   "id"=>nil, "created_at"=>nil, "updated_at"=>nil,
#   "queries_attributes"=>[
#     {"id"=>nil, "query"=>"foo", "created_at"=>nil, "updated_at"=>nil, "search_id"=>nil},
#     {"id"=>nil, "query"=>"bar", "created_at"=>nil, "updated_at"=>nil, "search_id"=>nil}
#   ]
# }

deserialized_search = Search.new(serialized_search)
deserialized_search.queries

# [
#   #<Query:0x00000003c59ee8 id: nil, query: "foo", created_at: nil, updated_at: nil, search_id: nil>,
#   #<Query:0x00000003c3f5e8 id: nil, query: "bar", created_at: nil, updated_at: nil, search_id: nil>
# ]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/msievers/nested_attributes_serializer.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
