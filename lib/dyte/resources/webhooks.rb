module Dyte
  class WebhooksResource < Resource
    def fetch(webhook_id:)
      Webhook.new get_request("webhooks/#{webhook_id}").body.dig("data")
    end

    def list
      response = get_request("webhooks")
      Collection.from_response(response, type: Webhook)
    end

    def create(**attributes)
      Webhook.new post_request("webhooks", body: attributes).body.dig("data")
    end
  end
end
