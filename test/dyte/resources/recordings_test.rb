require "test_helper"

class RecordingsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_list
    stub_request(:get, "#{Dyte::Client::BASE_URL}/recordings")
      .to_return(body: File.new("test/fixtures/recordings/list.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    recordings = client.recordings.list
    assert_equal Dyte::Collection, recordings.class
    assert_equal Dyte::Recording, recordings.data.first.class
    assert_equal "apple", recordings.data.first.id
  end

  def test_fetch
    stub_request(:get, "#{Dyte::Client::BASE_URL}/recordings/1")
      .to_return(body: File.new("test/fixtures/recordings/fetch.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    recordings = client.recordings.fetch(recording_id: 1)
    assert_equal Dyte::Recording, recordings.class
    assert_equal "salmonberry", recordings.id
  end
end
