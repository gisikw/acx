$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "acx"
require "minitest/autorun"
require "webmock/minitest"

def enable_fixtures
  stub_request(:get, /.*/).to_return do |req|
    file = File.join(File.dirname(__FILE__), "fixtures", req.uri.host, req.uri.path)
    { body: File.read(file) }
  end
end
