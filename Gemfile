source "https://rubygems.org"

gemspec

group :development do
  gem "activerecord"
  gem "bundler"
  gem "rake"
  gem "rubocop", "~> 0.41.1", require: false
  gem "rspec", "~> 3.0"
  gem "simplecov"
  gem "sqlite3"

  if !ENV["CI"] && RUBY_ENGINE == "ruby"
    gem "pry"

    if RUBY_VERSION < "2.0.0"
      gem "pry-nav"
    else
      gem "pry-byebug"
    end
  end
end
