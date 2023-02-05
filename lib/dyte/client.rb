require "minitest/autorun"
module Dyte
  class Client
    BASE_URL = "https://api.cluster.dyte.in/v1/organizations"

    attr_accessor :organization_id, :api_key, :adapter

    def initialize(organization_id:, api_key:, adapter: Faraday.default_adapter)
      @organization_id = organization_id
      @api_key = api_key
      @adapter = adapter
    end

    def meetings
      MeetingsResource.new(self)
    end

    def sessions
    end

    def connection
      @connection ||= Faraday.new("#{BASE_URL}/#{@organization_id}") do |conn|
        conn.headers["Authorization"] = @api_key
        conn.headers["Content-Type"] = "application/json"

        conn.response :json, content_type: "application/json"
      end
    end
  end
end
