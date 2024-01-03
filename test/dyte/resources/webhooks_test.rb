require "test_helper"

class WebhooksResourceTest < Minitest::Test
  def setup
    @organization_id = "SUPER_SECRET_ORGANIZATION_ID"
    @api_key = "SUPER_SECRET_API_KEY"
  end

  def test_fetch
    stub_request(:get, "#{Dyte::Client::BASE_URL}/webhooks/1")
      .to_return(body: File.new("test/fixtures/webhooks/fetch.json"), headers: {content_type: "application/json"})

    client = Dyte::Client.new(api_key: @api_key, organization_id: @organization_id)
    webhook = client.webhooks.fetch(webhook_id: 1)
    assert_equal Dyte::Webhook, webhook.class
    assert_equal "blueberry", webhook.id
  end
end
