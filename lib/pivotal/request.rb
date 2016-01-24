require 'net/http'
require 'open-uri'
require 'json'
require 'pivotal/errors'

module Pivotal
  module Request
    TOKEN = ENV['PIVOTAL_TOKEN']
    PROJECT = ENV['PIVOTAL_PROJECT_ID']

    def self.base_url
      "https://www.pivotaltracker.com/services/v5/projects/#{PROJECT}"
    end

    def self.get(endpoint, params={})
      url = base_url + '/' + endpoint
      url += '?' + URI.encode_www_form(params) unless params.empty?
      JSON.parse(open(url, {'X-TrackerToken' => TOKEN}) {|f| f.read})
    end

    def self.post(endpoint, params)
      uri = URI(base_url + '/' + endpoint)
      req = Net::HTTP::Post.new uri
      req.add_field('X-TrackerToken', TOKEN)
      req.add_field('Content-Type', 'application/json')
      req.body = params.to_json

      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.request req
      end

      JSON.parse(res.body)
    end
  end
end
