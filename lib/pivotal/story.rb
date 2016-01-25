require 'pivotal/api'
require 'pivotal/label'
require 'pivotal/request'

module Pivotal
  class Story < API

    attr_reader :story_type, :current_state, :url, :owner_ids, :owned_by_id

    def labels
      return [] if @labels.nil?
      @labels.map {|l| Label.new(l)}
    end

    def add_label(name)
      params = { name: name }
      endpoint = "stories/#{id}/labels"
      Request.post(endpoint, params)
    end

    def self.endpoint
      'stories'
    end

  end
end
