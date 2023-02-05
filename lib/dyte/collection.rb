module Dyte
  class Collection
    attr_reader :data, :total, :page_count, :current_page

    # from_response(response, key: 'meetings', type: Meeting)
    def self.from_response(response, key:, type:)
      body = response.body
      new(
        data: body.dig("data", key).map { |attrs| type.new(attrs) },
        total: body.dig("data", "total"),
        page_count: body.dig("data", "pageCount"),
        current_page: body.dig("data", "currentPage")
      )
    end

    def initialize(data:, total:, page_count:, current_page:)
      @data = data
      @total = total
      @page_count = page_count
      @current_page = current_page
    end
  end
end
