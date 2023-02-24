require "test_helper"

class ParticipantsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_list
    stub_request(:get, "#{Dyte::Client::BASE_URL}/sessions/1/participants")
      .to_return(body: File.new("test/fixtures/participants/list.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    participants = client.participants.list(session_id: 1)
    assert_equal Dyte::Participant, participants.data.first.class
    assert_equal "Mark", participants.data.first.display_name
  end

  def test_fetch
    stub_request(:get, "#{Dyte::Client::BASE_URL}/sessions/1/participants/1")
      .to_return(body: File.new("test/fixtures/participants/fetch.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    participant = client.participants.fetch(session_id: 1, participant_id: 1)
    assert_equal Dyte::Participant, participant.class
    assert_equal "blueberry", participant.user_id
  end
end
