require 'pivotal/api'
require 'pivotal/label'
require 'pivotal/request'

module Pivotal
  class Story < API

    attr_reader :created_at, :updated_at, :accepted_at, :story_type, :name, :current_state, :url,
                :owner_ids, :project_id, :owned_by_id, :kind, :id

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
