# Dyte

A gem that wraps v2 of the [Dyte API](https://docs.dyte.io/api/#/) to make it easy to use in Ruby applications.
Please note that some resources are not yet implemented. This is due to the fact that v2 of the Dyte API is incomplete. Once the Dyte team has finalized the response structure the remaining resources will be implemented.

Bugs reports and pull requests are welcome! ❤️

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'dyte'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dyte

## Usage

TODO: Write usage instructions here

## Resources
### Meetings
```ruby
client.meetings.list
client.meetings.fetch(meeting_id: "id")
client.meetings.create({})
client.meetings.update(meeting_id: "id", {})
client.meetings.regenerate_token(meeting_id: "id", participant_id: "id")
```
### Presets
```ruby
client.presets.list
client.presets.fetch(preset_id: "id")
client.presets.create({})
client.presets.update(preset_id: "id", {})
```
### Sessions
```ruby
client.sessions.list
client.sessions.fetch(session_id: "id")
client.sessions.fetch_participants(session_id: "id")
client.sessions.participant_details(session_id: "id", participant_id: "id")
client.sessions.chat_messages(session_id: "id")
```
### Participants

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Contribution guidelines TBD. For now just open a PR and we'll figure it out.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
