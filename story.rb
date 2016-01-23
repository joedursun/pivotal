require 'pivotal/label'
require 'pivotal/request'

module Pivotal
  class Story

    attr_reader :created_at, :updated_at, :accepted_at, :story_type, :name, :current_state, :url,
                :owner_ids, :project_id, :owned_by_id, :kind, :id

    def initialize(opts={})
      opts.each_pair do |attribute, value|
        self.instance_variable_set("@#{attribute}", value)
      end
    end

    def labels
      return [] if @labels.nil?
      @labels.map {|l| Label.new(l)}
    end

    def add_label(name)
      params = { name: name }
      endpoint = "stories/#{id}/labels"
      Request.post(endpoint, params)
    end

    def self.where(filters={})
      stories = Request.get('stories', filters) || []
      stories.map {|s| self.new(s)}
    end

    def self.create(opts)
      Request.post('stories', opts)
    end

  end
end
