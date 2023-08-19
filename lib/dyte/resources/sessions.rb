module Dyte
  class SessionsResource < Resource
    def list(**params)
      response = get_request("sessions", params: params)
      Collection.from_response(response, type: Session, key: "sessions")
    end

    def fetch(session_id:)
      Session.new get_request("sessions/#{session_id}").body.dig("data", "session")
    end

    # Returns a list of participants for the given session ID.
    # Kept it within the Sessions resource as that's how the Dyte API is structured.
    def fetch_participants(session_id:)
      Session.new get_request("sessions/#{session_id}/participants").body.dig("data")
    end

    def participant_details(session_id:, participant_id:)
      get_request("sessions/#{session_id}/participants/#{participant_id}").body.dig("data")
    end

    def chat_messages(session_id:)
      get_request("sessions/#{session_id}/chat").body.dig("data")
    end
  end
end
