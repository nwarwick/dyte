module Dyte
  class MeetingsResource < Resource
    def list(**params)
      response = get_request("meetings", params: params)
      Collection.from_response(response, key: "meetings", type: Meeting)
    end

    def fetch(meeting_id:)
      Meeting.new get_request("meetings/#{meeting_id}").body.dig("data", "meeting")
    end

    def create(attributes)
      Meeting.new post_request("meeting", body: attributes).body.dig("data", "meeting")
    end

    def update(meeting_id:, body: {})
      Meeting.new put_request("meetings/#{meeting_id}", body: body).body.dig("data", "meeting")
    end
  end
end
