# Erlash

Erlash, errors that make sense.
The ruby implementation for errors is tedious and makes it hard to write descriptive errors.
In production you can find errors that do not explain the context and gives you no clue what's going on.

You can find errors like:

```
ValidationError:
  email already token
```

Wouldn't be nice to have more information about the error?

example:
```
RequestError:
 Problem:
   User is unable to update his email
 Summary:
   Validation errors: email already token
 Context:
   - request_id: `123`
   - user: { id: 1, email: `mail@example.com` }
   - endpoint: `PUT /users/1`
   - params: { email: `another@email.com` }
```

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

raise Myerror, { user_id: 1, request_id: 120, controller: 'users_controller' }
# Myerror:
#   - user_id: 1
#   - request_id: 120
#   - controller: `users_controller`
```

```ruby
class MyError < Erlash::Base;
  problem -> { |context| "Please user `#{context[:user_id]}` be careful" }
  summary "This error usually happens when user clicks too fast"
  resolution -> { |context| "User.find(#{context[:user_id]}).fix" }
end

raise Myerror, { user_id: 1, request_id: 120, controller: 'users_controller' }
# Myerror:
#  Problem:
#    Please user `1` be careful
#  Summary:
#    This error usually happens when user clicks too fast
#  Resolution:
#    User.find(1).fix
#  Context:
#    - user_id: 1
#    - request_id: 120
#    - controller: `users_controller`
```

### Formatters
Erlash is fully customizable.
You can add formatters for your objects or override the defaults.

__Create your formatter:__

Create a class that inherits from `Erlash::TemplateFormatter` and implement the method `format`.

```ruby
class MyUserFormatter < Erlash::TemplateFormatter
  def format
    "And the name is: #{object.name}"
  end
end
```

__Register your formatter:__

When registering a formatter you should provide the class is going to format as first argument.
Arguments:
- class to be formatted. ex: `User`
- formatter for given class. ex: `MyUserFormatter`

```ruby
Erlash.formatters.register(User, MyUserFormatter)
```

__Erlash::TemplateFormatter__

Accessible methods:
- `object`: is an instance of the registered class. in the example `User` instance
- `format_elem`: will try to find a formatter for given object if not will default `to_s`

  * args: [object]

example:

```ruby
class User
  def email
    "mail@example.com"
  end
  def id; 1 end
  def errors
    "email already token"
  end
end

class Erlash::UserFormatter < Erlash::TemplateFormatter
  def format
    format_elem({
      id: object.id,
      email: object.email
    }) # it will be formatted by the registered formatter for Hash
  end
end

Erlash.formatters.register(User, Erlash::UserFormatter)

class RequestError < Erlash::Base
  problem "User is unable to update his email"
  summary do |context|
    "Validation errors: #{context[:user].errors}"
  end
end

raise RequestError.new(request_id: '123', user: User.new, endpoint: 'PUT /users/1', params: {email: "another@email.com"})
# RequestError:
#   Problem:
#     User is unable to update his email
#   Summary:
#     Validation errors: email already token
#   Context:
#     - request_id: `123`
#     - user: { id: 1, email: `mail@example.com` }
#     - endpoint: `PUT /users/1`
#     - params: { email: `another@email.com` }
```

Default formatters:

* `Array` => `Erlash::ArrayFormatter`
* `Hash` => `Erlash::HashFormatter`
* `String` => `Erlash::StringFormatter`

Custom Erlash classes:

* `Erlash::Tip` => `Erlash::TipFormatter`
* `Erlash::Context` => `Erlash::ContextFormatter`
* `Erlash::MainArray` => `Erlash::MainArrayFormatter`
* `Erlash::MainHash` => `Erlash::MainHashFormatter`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arturictus/erlash. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Erlash project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/erlash/blob/master/CODE_OF_CONDUCT.md).
