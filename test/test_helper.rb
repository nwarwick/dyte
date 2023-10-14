$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "dyte"
require "minitest/autorun"
require "faraday"
require "json"
require "webmock/minitest"
require "debug"

class Minitest::Test
end
