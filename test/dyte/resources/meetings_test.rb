require "test_helper"
require "faraday"

class MeetingsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_list
    stub_request(:get, "#{Dyte::Client::BASE_URL}/#{@organization_id}/meetings")
      .to_return(body: File.new("test/fixtures/meetings/list.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id, adapter: :test)
    meetings = client.meetings.list
    assert_equal Dyte::Collection, meetings.class
    assert_equal Dyte::Meeting, meetings.data.first.class
    assert_equal 2, meetings.total
  end

  def test_fetch
    stub_request(:get, "#{Dyte::Client::BASE_URL}/#{@organization_id}/meetings/1")
      .to_return(body: File.new("test/fixtures/meetings/fetch.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id, adapter: :test)
    meeting = client.meetings.fetch(meeting_id: 1)
    assert_equal Dyte::Meeting, meeting.class
    assert_equal "Meeting 1", meeting.title
  end

  def test_create
    body = {
      title: "string",
      presetName: "string",
      authorization: {
        waitingRoom: false,
        closed: false
      },
      recordOnStart: false,
      liveStreamOnStart: false
    }

    stub_request(:post, "#{Dyte::Client::BASE_URL}/#{@organization_id}/meeting")
      .to_return(body: File.new("test/fixtures/meetings/create.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id, adapter: :test)
    meeting = client.meetings.create(body)
    assert_equal Dyte::Meeting, meeting.class
    assert_equal "Meeting 1", meeting.title
  end

  def test_update
    body = {title: "updated title"}
    meeting_id = "d8b1a76b-fcd8-413d-8a59-0017e825cfa3"

    stub_request(:put, "#{Dyte::Client::BASE_URL}/#{@organization_id}/meetings/#{meeting_id}")
      .to_return(body: File.new("test/fixtures/meetings/update.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id, adapter: :test)
    assert client.meetings.update(meeting_id: meeting_id, body: body)
  end
end
