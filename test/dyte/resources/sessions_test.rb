require "test_helper"
# TODO: Add support for fetching session messages. Move to separate Message resource?
# https://docs.dyte.io/api/#/operations/GetSessionChat
class SessionsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_list
    stub = stub_request(:get, "#{Dyte::Client::BASE_URL}/sessions")
      .to_return(body: File.new("test/fixtures/sessions/list.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    sessions = client.sessions.list
    assert_equal Dyte::Collection, sessions.class
    assert_equal Dyte::Session, sessions.data.first.class
    assert_requested stub
  end

  def test_fetch
    stub_request(:get, "#{Dyte::Client::BASE_URL}/sessions/1")
      .to_return(body: File.new("test/fixtures/sessions/fetch.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    session = client.sessions.fetch(session_id: 1)
    assert_equal Dyte::Session, session.class
    assert_equal "apricot", session.id
  end
end
