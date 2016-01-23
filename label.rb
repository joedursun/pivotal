require 'request'

module Pivotal
  class Label
    attr_reader :id, :project_id, :name, :created_at, :updated_at

    def initialize(opts={})
      opts.each_pair do |attribute, value|
        self.instance_variable_set("@#{attribute}", value)
      end
    end

    def self.create(opts)
      Request.post('labels', opts)
    end
  end
end
