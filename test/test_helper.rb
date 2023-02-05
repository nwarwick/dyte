$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "dyte"
require "minitest/autorun"
require "faraday"
require "json"
require "webmock/minitest"

class Minitest::Test
end
