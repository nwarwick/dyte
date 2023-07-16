module Dyte
  class ActiveSessionsResource < Resource
    def fetch(meeting_id:)
      ActiveSession.new get_request("meetings/#{meeting_id}/active-session").body.dig("data")
    end
  end
end
