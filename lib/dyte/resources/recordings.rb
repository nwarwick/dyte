module Dyte
  class RecordingsResource < Resource
    # Returns all recordings for an organization.
    # If the meeting_id parameter is passed, returns all recordings for the given meeting ID.
    def list(**params)
      response = get_request("recordings", params: params)
      Collection.from_response(response, type: Recording)
    end

    def fetch(recording_id:)
      Recording.new get_request("recordings/#{recording_id}").body.dig("data")
    end
  end
end
