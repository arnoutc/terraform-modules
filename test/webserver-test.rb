#!/usr/bin/env ruby

require 'test/unit'
require './webserver'

class TestWebServer < Test::Unit::TestCase
    def initialize(test_method_name)
        super(test_method_name)
        @handlers = Handlers.new
    end

    def test_unit_hello
        status_code, content_type, body = @handlers.handle("/")
        assert_equal(200, status_code)
        assert_equal('text/plain', content_type)
        assert_equal('Hello, World', body)
    end

    def test_unit_api
        status_code, content_type, body = @handlers.handle("/api")
        assert_equal(201, status_code)
        assert_equal('application/json', content_type)
        assert_equal('{"foo":"bar"}', body)
    end

    def test_unit_404
        status_code, content_type, body = @handlers.handle("/invalid-path")
        assert_equal(404, status_code)
        assert_equal('text/plain', content_type)
        assert_equal('Not Found', body)
    end
end