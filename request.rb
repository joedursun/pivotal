require 'uri'
require 'json'

module Pivotal
  module Request
    def self.base_url
      project = ENV['PIVOTAL_PROJECT_ID'] || 1487596
      "https://www.pivotaltracker.com/services/v5/projects/#{project}"
    end

    def self.get(endpoint, params={})
      url = base_url + '/' + endpoint
      url += '?' + URI.encode_www_form(params) unless params.empty?
      JSON.parse(open(url, {'X-TrackerToken' => ENV['PIVOTAL_TOKEN']}) {|f| f.read})
    end

    def self.post(url, params)
      # FIXME
    end
  end
end
