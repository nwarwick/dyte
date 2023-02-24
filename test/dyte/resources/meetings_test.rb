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
end
