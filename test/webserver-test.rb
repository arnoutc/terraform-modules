#!/usr/bin/env ruby

require 'test/unit'
require './webserver'
require 'net/http'

class TestWebServer < Test::Unit::TestCase

    def initialize(test_method_name)
        super(test_method_name)
        mock_web_service = MockWebService.new([200, 'text/html', 'mock example.org'])
        @handlers = Handlers.new(mock_web_service)
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

    def test_unit_web_service
        expected_status = 200
        expected_content_type = 'text/html'
        expected_body = 'mock example.org'
        mock_response = [expected_status, expected_content_type, expected_body]

        mock_web_service = MockWebService.new(mock_response)
        handlers = Handlers.new(mock_web_service)
        
        status_code, content_type, body = handlers.handle("/web-service")
        assert_equal(expected_status, status_code)
        assert_equal(expected_content_type, content_type)
        assert_equal(expected_body, body)
    end

    def test_unit_404
        status_code, content_type, body = @handlers.handle("/invalid-path")
        assert_equal(404, status_code)
        assert_equal('text/plain', content_type)
        assert_equal('Not Found', body)
    end
end

class MockWebService
    def initialize(response)
        @response = response
    end

    def proxy
        @response
    end
end