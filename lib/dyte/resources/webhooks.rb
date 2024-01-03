module Dyte
  class WebhooksResource < Resource
    def fetch(webhook_id:)
      Webhook.new get_request("webhooks/#{webhook_id}").body.dig("data")
    end
  end
end
