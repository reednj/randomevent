# RandomEvent

RandomEvent is a DSL that makes it easy to create a set of blocks such that a single one in the set will be executed, based off the probability assigned to each one.

Example:

	# half of the time it will output hello, 25% of the time goodbye
	# and 25 % of the time the default will be executed
	RandomEvent.new do |r|
		r.chance 0.50 do
			puts 'hello'
		end

		r.chance 0.25 do
			puts 'goodbye'
		end

		# this is optional, there is no need to have a default case
		# if it is not requried
		r.chance :else do
			puts '-'
		end
	end

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'randomevent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install randomevent

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/randomevent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
