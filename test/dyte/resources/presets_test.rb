require "test_helper"
require "faraday"

class PresetsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_list
    stub_request(:get, "#{Dyte::Client::BASE_URL}/presets")
      .to_return(body: File.new("test/fixtures/presets/list.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    presets = client.presets.list
    assert_equal Dyte::Collection, presets.class
    assert_equal Dyte::Preset, presets.data.first.class
    assert_equal "apple", presets.data.first.id
    assert_equal 2, presets.total_count
  end

  def test_create
    stub = stub_request(:post, "#{Dyte::Client::BASE_URL}/presets")
      .to_return(body: File.new("test/fixtures/presets/create.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    preset = client.presets.create(name: "kiwi-preset")
    assert_requested stub # TODO: Confirm this is working by removing the request
    assert_equal Dyte::Preset, preset.class
    assert_equal "kiwi-preset", preset.name
  end

  def test_fetch
    stub = stub_request(:get, "#{Dyte::Client::BASE_URL}/presets/1")
      .to_return(body: File.new("test/fixtures/presets/fetch.json"), headers: {content_type: "application/json"})
    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    preset = client.presets.fetch(preset_id: 1)

    assert_requested stub
    assert_equal Dyte::Preset, preset.class
    assert_equal "kiwi-preset", preset.name
  end

  def test_delete
    stub = stub_request(:delete, "#{Dyte::Client::BASE_URL}/presets/1")
      .to_return(body: File.new("test/fixtures/presets/delete.json"), headers: {content_type: "application/json"})
    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    preset = client.presets.delete(preset_id: 1)

    assert_requested stub
    assert_equal Dyte::Preset, preset.class
    assert_equal "kiwi-preset", preset.name
  end

  def test_update
    stub = stub_request(:patch, "#{Dyte::Client::BASE_URL}/presets/1")
      .to_return(body: File.new("test/fixtures/presets/update.json"), headers: {content_type: "application/json"})
    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    preset = client.presets.update(preset_id: 1)

    assert_requested stub
    assert_equal Dyte::Preset, preset.class
    assert_equal "pineapple", preset.name
  end
end
