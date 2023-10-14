require "test_helper"

class OrganizationsResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_create
    stub_request(:post, "#{Dyte::Client::BASE_URL}/orgs")
      .to_return(body: File.new("test/fixtures/organizations/create.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    organization = client.organizations.create(name: "Dyte", contact: "778-330-2389", website: "https://www.dyte.io", feature_flags: ["string"], preferred_region: "ap-south-1")
    assert_equal Dyte::Organization, organization.class
    assert_equal "Dyte", organization.name
  end
end
