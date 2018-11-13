# Erlash

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/erlash`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'erlash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install erlash

## Usage

```ruby
class MyError < Erlash::Base; end

raise Myerror.new(user_id: 1, request_id: 120, controller: 'users_controller')
# Myerror:
#
# Context:
#   - user_id: 1
#   - request_id: 120
#   - controller: `users_controller`
```

```ruby
class MyError < Erlash::Base;
  problem -> { |e| "Please user `#{context[:user_id]}` be careful" }
  summary "This error usually happens when user is desperate for the bug"
  resolution -> { "User.find(#{context[:user_id]}).fix" }
end

raise Myerror.new(user_id: 1, request_id: 120, controller: 'users_controller')
# Myerror:
# Please user `1` be careful
#
# Summary:
#   This error usually happens when user is desperate for the bug
#   blablabla
# Resolution:
#   User.find(1).fix
# Context:
#   - user_id: 1
#   - request_id: 120
#   - controller: `users_controller`
```

### Add formatters
```ruby
class User
  def email
    "mail@example.com"
  end
  def id; 1 end
end

class Erlash::UserFormatter < Erlash::TemplateFormatter
  def format
    "id: #{object.id}, email: #{object.email}"
  end
end

Erlash.formatters.register(User, Erlash::UserFormatter)

class RequestError < Erlash::Base; end
RequestError.new(request_id: '123', user: User.new, endpoint: 'PUT /users/1', params: {email: "another@email.com"})

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/erlash. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Erlash project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/erlash/blob/master/CODE_OF_CONDUCT.md).
