# frozen_string_literal: true

require "openssl"
require "net/http"
require "json"

module Slice
  # Generates JSON web requests for POST and PATCH.
  class SendJson
    class << self
      def get(url)
        new(url).get
      end

      def post(url, *args)
        new(url, *args).post
      end

      def patch(url, *args)
        new(url, *args).patch
      end
    end

    def initialize(url, args = {})
      @params = args
      @url = URI.parse(url)

      @http = Net::HTTP.new(@url.host, @url.port)
      if @url.scheme == "https"
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    rescue URI::InvalidURIError
      @error = "Invalid URL: #{url.inspect}"
      puts @error.red
    end

    def get
      return if @error

      header = { "Content-Type" => "application/json", "Accept" => "application/json" }
      response = @http.start do |http|
        http.get(@url, header)
      end
      [JSON.parse(response.body), response]
    rescue => e
      puts "POST ERROR".red
      puts e.to_s.white
      [nil, response]
    end

    def post
      return if @error

      header = { "Content-Type" => "application/json", "Accept" => "application/json" }
      response = @http.start do |http|
        http.post(@url.path, @params.to_json, header)
      end
      [JSON.parse(response.body), response]
    rescue => e
      puts "POST ERROR".red
      puts e.to_s.white
      [nil, response]
    end

    def patch
      @params["_method"] = "patch"
      post
    end
  end
end
