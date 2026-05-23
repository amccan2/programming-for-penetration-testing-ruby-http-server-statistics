#!/usr/bin/ruby

require 'net/http'

class ServerHead

    def initialize(host, port=80)
        @host = host
        @port = port
        @head = nil
        begin
            Net::HTTP.start(@host.to_s, @port) do |http|
                @head = http.head('/') # HEAD method.
            end
        rescue
            @head = nil
        end
    end

    def empty?
        return @head.nil?
    end

    def getServerAndCookie()
        if @head
            return [@head['server'], @head['set-cookie']]
        else
            return [nil, nil]
        end
    end
end 



