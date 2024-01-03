require "faraday"
require "json"
require "dyte/version"
require "dyte/client"
require "dyte/collection"
require "dyte/error"
require "dyte/object"
require "dyte/resource"

# Objects
require "dyte/objects/meeting"
require "dyte/objects/preset"
require "dyte/objects/participant"
require "dyte/objects/session"
require "dyte/objects/recording"
require "dyte/objects/active_session"
require "dyte/objects/organization"
require "dyte/objects/webhook"

# Resources
require "dyte/resources/meetings"
require "dyte/resources/presets"
require "dyte/resources/participants"
require "dyte/resources/sessions"
require "dyte/resources/recordings"
require "dyte/resources/active_sessions"
require "dyte/resources/organizations"
require "dyte/resources/webhooks"

module Dyte
end
