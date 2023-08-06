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
      Session.new get_request("sessions/#{session_id}/participants/#{participant_id}").body.dig("data")
    end

    def update(meeting_id:, **attributes)
      Session.new put_request("sessions/#{meeting_id}", body: attributes).body.dig("data", "session")
    end

    def update_old(meeting_id:, body: {})
      Session.new put_request("sessions/#{meeting_id}", body: body).body.dig("data", "session")
    end

    def chat_messages(session_id:)
      Session.new get_request("sessions/#{session_id}/chat").body.dig("data")
    end
  end
end
