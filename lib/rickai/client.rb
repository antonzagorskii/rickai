require 'net/http'
require 'multi_json'

module Rickai
  DEFAULT_BASE_URI = 'https://exchange.rick.ai'.freeze
  DEFAULT_TIMEOUT = 10

  class Client
    class InvalidResponse < RuntimeError; end

    def initialize(agent_url, options = {})
      @agent_url = agent_url
      @base_uri = options[:base_uri] || DEFAULT_BASE_URI
      @timeout = options[:timeout] || DEFAULT_TIMEOUT
    end

    def update(attributes)
      verify_response(request(url_update, attributes))
    end

    def create(attributes)
      verify_response(request(url_create, attributes))
    end

    def check(attributes)
      verify_response(request(url_check, attributes))
    end

    def lead(attributes)
      verify_response(request(url_lead, attributes))
    end

    private

    def url_create
      "/transactions/#{@agent_url}/create"
    end

    def url_update
      "/transactions/#{@agent_url}/update"
    end

    def url_check
      "/transactions/#{@agent_url}/check"
    end

    def url_lead
      "/webhooks/#{@agent_url}/lead"
    end

    def verify_response(response)
      if response.code.to_i >= 200 && response.code.to_i < 300
        response
      else
        raise InvalidResponse, "Rick.ai API returned an invalid response: #{response.code} - #{response.message}"
      end
    end

    def request(path, body = nil, headers = {})
      uri = URI.join(@base_uri, path)

      session = Net::HTTP.new(uri.host, uri.port)
      session.use_ssl = (uri.scheme == 'https')
      session.open_timeout = @timeout
      session.read_timeout = @timeout

      req = Net::HTTP::Post.new(uri.path)
      req.initialize_http_header(headers)

      req.add_field('Content-Type', 'application/json')

      unless body.nil?
        attributes =
          if body.is_a?(Hash)
            Hash[body.map { |(k, v)| [k.to_sym, v] }]
          else
            body.map { |item| Hash[item.map { |(k, v)| [k.to_sym, v] }] }
          end

        req.body = MultiJson.dump(attributes)
      end

      session.start do |http|
        http.request(req)
      end
    end
  end
end
