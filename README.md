<p align="center">
  <img src="https://github.com/kirillshevch/vandal/raw/master/vandal.jpg?sanitize=true" width="65%" alt="Vandal Logo"/>
</p>

A small gem that help to *delete an ActiveRecord instance or collection with associations* (skipping callbacks or validations) 

## Installation

Add this line to your application's Gemfile and then execute `bundle install`

```ruby
gem 'vandal'
```

## Usage

Vandal gem adds 2 methods to `ActiveRecord::Base`

## #vandal_destroy

Delete an ActiveRecord instance with associations even if the callbacks return false or rescue error.

```ruby
class User
  has_many :followers # Does not even contain dependent: :destroy
end

User.find_by(id: 1).vandal_destroy
```

Followers will deleted along with `User`.

## #vandal_destroy_all

Applies `vandal_destroy!` for ActiveRecord collection

```ruby
User.all.vandal_destroy_all
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kirillshevch/vandal.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
