require "test_helper"
require "faraday"

class MeetingsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_list
    stub = stub_request(:get, "#{Dyte::Client::BASE_URL}/meetings")
      .to_return(body: File.new("test/fixtures/meetings/list.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    meetings = client.meetings.list
    assert_equal Dyte::Collection, meetings.class
    assert_equal Dyte::Meeting, meetings.data.first.class
    assert_equal 2, meetings.total_count
    assert_requested stub # TODO: Confirm this is working by removing the request
  end

  def test_fetch
    stub_request(:get, "#{Dyte::Client::BASE_URL}/meetings/1")
      .to_return(body: File.new("test/fixtures/meetings/fetch.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    meeting = client.meetings.fetch(meeting_id: 1)
    assert_equal Dyte::Meeting, meeting.class
    assert_equal "apricot", meeting.id
  end

  def test_create
    stub_request(:post, "#{Dyte::Client::BASE_URL}/meetings")
      .to_return(body: File.new("test/fixtures/meetings/create.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    meeting = client.meetings.create(title: "Mango Meeting", preset_name: "Mango Preset")
    assert_equal Dyte::Meeting, meeting.class
    assert_equal "cherry", meeting.id
  end

  def test_update
    body = {title: "updated title"}
    meeting_id = "d8b1a76b-fcd8-413d-8a59-0017e825cfa3"

    stub_request(:put, "#{Dyte::Client::BASE_URL}/meetings/#{meeting_id}")
      .to_return(body: File.new("test/fixtures/meetings/update.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    assert client.meetings.update(meeting_id: meeting_id, body: body)
  end

  def test_regenerate_token
    meeting_id = "d8b1a76b-fcd8-413d-8a59-0017e825cfa3"

    stub_request(:post, "#{Dyte::Client::BASE_URL}/meetings/#{meeting_id}/participants/1/token")
      .to_return(body: File.new("test/fixtures/meetings/token.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    assert client.meetings.regenerate_token(meeting_id: meeting_id, participant_id: 1)
  end

  def test_fetch_participants
    stub_request(:get, "#{Dyte::Client::BASE_URL}/meetings/1/participants")
      .to_return(body: File.new("test/fixtures/meetings/fetch_participants.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    participants = client.meetings.fetch_participants(meeting_id: 1)
    assert_equal Dyte::Collection, participants.class
    assert_equal Dyte::Participant, participants.data.first.class
    assert_equal 30, participants.total_count
  end

  def test_delete_participant
    stub_request(:delete, "#{Dyte::Client::BASE_URL}/meetings/1/participants/1337")
      .to_return(body: File.new("test/fixtures/meetings/delete_participant.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    response = client.meetings.delete_participant(meeting_id: 1, participant_id: 1337)
    assert_equal 200, response.status
  end

  def test_edit_participant_details
    attributes = {name: "Jane Doe", picture: "http://example.com", preset_name: "string"}.to_json

    stub_request(:patch, "#{Dyte::Client::BASE_URL}/meetings/1/participants/1337")
      .to_return(body: File.new("test/fixtures/meetings/edit_participant_details.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    participant = client.meetings.edit_participant_details(meeting_id: 1, participant_id: 1337, attributes: attributes)
    assert_equal "string", participant.name
    assert_equal "http://example.com", participant.picture
    assert_equal "string", participant.token
  end

  def test_fetch_participant_details
    stub_request(:get, "#{Dyte::Client::BASE_URL}/meetings/1/participants/1337")
      .to_return(body: File.new("test/fixtures/meetings/fetch_participant_details.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    participant = client.meetings.fetch_participant_details(meeting_id: 1, participant_id: 1337)
    assert_instance_of Dyte::Participant, participant
    assert_equal "string", participant.name
    assert_equal "http://example.com", participant.picture
    assert_equal "string", participant.preset_name
  end
end
