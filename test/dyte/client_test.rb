require "test_helper"

class ClientTest < Minitest::Test
  def setup
    @client = Dyte::Client.new(api_key: "SUPER_SECRET_API_KEY", organization_id: "SUPER_SECRET_ORGANIZATION_ID")
  end

  def test_api_key
    assert_equal "SUPER_SECRET_API_KEY", @client.api_key
  end

  def test_organization_id
    assert_equal "SUPER_SECRET_ORGANIZATION_ID", @client.organization_id
  end
end
