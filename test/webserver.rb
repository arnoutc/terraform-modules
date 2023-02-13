#!/usr/bin/env ruby

require 'net/http'
require "webrick"

=begin
    WEBrick is a Ruby library that makes it easy to build an HTTP server with Ruby. 
    It comes with most installations of Ruby by default (it’s part of the standard library), 
    so you can usually create a basic web/HTTP server with only several lines of code.
    
    The following code creates a generic WEBrick server on the local machine on port 1234, 
    shuts the server down if the process is interrupted (often done with Ctrl+C).
    This example lets you call the URL's: "add" and "subtract" and pass through arguments to them
    Example usage: 
        http://localhost:1234/ (this will show the specified error message)
        http://localhost:1234/add?a=10&b=10 
        http://localhost:1234/subtract?a=10&b=9
=end

class WebServer < WEBrick::HTTPServlet::AbstractServlet
    def do_GET(request, response)
        web_service = WebService.new("http://www.example.org")
        handlers = Handlers.new(web_service)

        status_code, content_type, body = handlers.handle(request.path)

        response.status = status_code
        response['Content-Type'] = content_type
        response.body = body
    end
end

class WebService
    def initialize(url)
        @uri = URI(url)
    end

    def proxy
        response = Net::HTTP.get_response(@uri)
        [response.code.to_i, response['Content-Type'], response.body]
    end
end

class Handlers
    def initialize(web_service)
        @web_service = web_service
    end

    def handle(path)
        case path
        when "/"
            [200, 'text/plain', 'Hello, World']
        when "/api"
            [201, 'application/json', '{"foo":"bar"}']
        when "/web-service"
            # New endpoint that calls a web service
            @web_service.proxy
        else
            [404, 'text/plain', 'Not Found']
        end
    end
end

# This will only run if this script was called directly from the CLI, but
# not if it was required from another file
if __FILE__ == $0
    # Run the server on localhost at port 8000
    server = WEBrick::HTTPServer.new :Port => 8000
    server.mount '/', WebServer
    
    # Shut down the server on CTRL+C
    trap 'INT' do server.shutdown end

    # Start the server
    server.start
end