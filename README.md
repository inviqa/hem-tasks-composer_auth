# Hem::Tasks::ComposerAuth

Contains tasks for [Hem](https://github.com/inviqa/hem) to set up authentication for composer.

## Installation

Add these lines to your application's Hemfile:

```ruby
plugins do
  gem 'hem-tasks-composer_auth', '~> 1.0.0'
end
```

then either:
```ruby
after 'tools:composer', 'deps:auth:composer:file'
```
or:
```ruby
after 'tools:composer', 'deps:auth:composer:config'
```

## Usage

Run the following to see usage:

```bash
hem deps auth composer
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/inviqa/hem-tasks-composer_auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
