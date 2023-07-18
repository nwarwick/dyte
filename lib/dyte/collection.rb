module Dyte
  class Collection
    attr_reader :data, :total_count, :start_offset, :end_offset

    # from_response(response, type: Meeting)
    def self.from_response(response, type:, key: nil)
      body = response.body
      new(
        data: parse_body(body: body, type: type, key: key),
        total_count: body.dig("paging", "total_count"),
        start_offset: body.dig("paging", "start_offset"),
        end_offset: body.dig("paging", "end_offset")
      )
    end

    # As of now the session response differs from the other responses.
    # It's missing pagination data and also the data is nested under 'sessions'.
    def self.from_sessions_response(response, type:)
      body = response.body
      new(
        data: body.dig("data", "sessions").map { |attrs| type.new(attrs) }
      )
    end

    def initialize(data:, total_count: nil, start_offset: nil, end_offset: nil)
      @data = data
      @total_count = total_count
      @start_offset = start_offset
      @end_offset = end_offset
    end

    # The Dyte API does not have a consistent response structure. This method accounts for that.
    def self.parse_body(body:, type:, key: nil)
      if body["data"].is_a?(Array)
        body["data"].map { |attrs| type.new(attrs) }
      else
        body.dig("data", key).map { |attrs| type.new(attrs) }
      end
    end
  end
end
