require "minitest/autorun"
module Dyte
  class Client
    BASE_URL_V1 = "https://api.cluster.dyte.in/v1/organizations"
    BASE_URL = "https://api.cluster.dyte.in/v2"

    attr_accessor :organization_id, :api_key, :adapter

    def initialize(organization_id:, api_key:, adapter: Faraday.default_adapter)
      @organization_id = organization_id
      @api_key = api_key
      @adapter = adapter
    end

    def meetings
      MeetingsResource.new(self)
    end

    def presets
      PresetsResource.new(self)
    end

    def participants
      ParticipantsResource.new(self)
    end

    def sessions
      SessionsResource.new(self)
    end

    def recordings
      RecordingsResource.new(self)
    end

    def active_sessions
      ActiveSessionsResource.new(self)
    end

    def connection_v1
      @connection ||= Faraday.new("#{BASE_URL}/#{@organization_id}") do |conn|
        conn.headers["Authorization"] = @api_key

        conn.request :json

        conn.response :json, content_type: "application/json"
      end
    end

    def connection
      auth_token = Base64.strict_encode64("#{@organization_id}:#{@api_key}")
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.headers["Authorization"] = "Basic #{auth_token}"

        conn.request :json

        conn.response :json, content_type: "application/json"
      end
    end
  end
end
