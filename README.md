# Dyte

A gem that wraps v2 of the [Dyte API](https://docs.dyte.io/api/#/) to make it easy to use in Ruby applications.
Please note that some resources are not yet implemented. This is due to the fact that v2 of the Dyte API is incomplete. Once the Dyte team has finalized the response structure the remaining resources will be implemented. In order to obtain access to v2 of the Dyte API please contact the Dyte team.

Issues and pull requests are welcome! ❤️

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'dyte'
```

And then execute:

    $ bundle install

## Usage

TODO: Write usage instructions here

## Resources

### Meetings

```ruby
# Returns all meetings in an organization.
client.meetings.list

# Returns a meeting in an organization for the given meeting ID.
client.meetings.fetch(meeting_id: "id")

# Creates a meeting in an organization.
client.meetings.create({})

# Updates a meeting in an organization for the given meeting ID.
client.meetings.update(meeting_id: "id", {})

# Regenerates participant's authentication token for the given meeting and participant ID.
client.meetings.regenerate_token(meeting_id: "id", participant_id: "id")

# Returns all participants for the given meeting ID.
client.meetings.fetch_participants(meeting_id: "id") 

# Returns a participant for the given meeting and participant ID.
client.meetings.fetch_participant_details(meeting_id: "id", participant_id: "id")

# Edits a participant for the given meeting and participant ID.
client.meetings.edit_participant_details(meeting_id: "id", participant_id: "id")

# Adds a participant to a meeting.
client.meetings.add_participant(meeting_id: "id", participant_id: "id")

# Replaces specified details for the given meeting ID.
client.meetings.replace( meeting_id: "id", {})
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
### Organizations

```ruby
# Creates a new organization. The authenticated user becomes the owner of the organization.
client.organizations.create(
    {
        "name": "Cool Org",
        "contact": "778-330-2389",
        "website": "https://www.dyte.io",
        "feature_flags": [
            "string"
        ],
        "preferred_region": "ap-south-1"
    }
)

# Updates organization details for the given organization ID. The user must be the organization's owner.
client.organizations.update(organization_id: "id", 
    {
        "name": "A much better name",
        "contact": "string",
        "website": "https://www.dyte.io",
        "feature_flags": [
            "string"
        ],
        "preferred_region": "ap-south-1"
    }
)
```
### Webhooks
```ruby
# Returns the Webhook relating to the given ID
client.webhooks.fetch(webhook_id: "id")

# Returns all Webhooks for a given organization
client.webhooks.list

# Creates a new webhook 
client.webhooks.create(
    {
        "name": "Cool Webhook",
        "url": "https://webhook.site/b23a5bbd-c7b0-4ced-a9e2-78ae7889897e",
        "events": [
            "meeting.started",
            "meeting.ended",
            "meeting.participantJoined",
            "meeting.participantLeft",
            "meeting.chatSynced",
            "recording.statusUpdate",
            "livestreaming.statusUpdate"
        ],
        "enabled": true
    }
)
```

### Participants

## Development
### Setup
After checking out the repo run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. 

### Running Locally
It can be convenient to run the gem locally while developing, to test changes. To do so, follow these steps:
1) Run `bin/console` from the root directory
1) Instantiate the client (enter your Dyte credentials) `client = Client.new(organization_id: '1234', api_key: '1234')`
1) Run a test command, for example: `client.participants.list(session_id: 1)`


## Contributing

Contribution guidelines TBD. For now just open a PR and we'll figure it out.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
