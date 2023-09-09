# This module is deprecated in favour of adding participant actions to the meetings resource. This is for the purpose
# of better following how Dyte's API is structured. This module will be removed in a future release.
module Dyte
  class ParticipantsResource < Resource
    def list(session_id:, **params)
      response = get_request("sessions/#{session_id}/participants", params: params)
      Collection.from_response(response, type: Participant, key: "participants")
    end

    def fetch(session_id:, participant_id:)
      Participant.new get_request("sessions/#{session_id}/participants/#{participant_id}").body.dig("data", "participant")
    end
  end
end
