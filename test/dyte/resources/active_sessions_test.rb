require "test_helper"

class ActiveSessionsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_fetch
    stub_request(:get, "#{Dyte::Client::BASE_URL}/meetings/1/active-session")
      .to_return(body: File.new("test/fixtures/active_sessions/fetch.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    active_session = client.active_sessions.fetch(meeting_id: 1)
    assert_equal Dyte::ActiveSession, active_session.class
    assert_equal "pear", active_session.id
  end
end
