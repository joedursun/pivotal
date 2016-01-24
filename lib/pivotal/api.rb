require 'pivotal/request'

module Pivotal
  class API

    def endpoint
      raise 'You must define an endpoint in the child class.'
    end

    def initialize(opts={})
      opts.each_pair do |attribute, value|
        self.instance_variable_set("@#{attribute}", value)
      end
    end

    def self.where(endpoint, filters={})
      stories = Request.get(endpoint, filters) || []
      stories.map {|s| self.new(s)}
    end

    def self.create(opts)
      Request.post(endpoint, opts)
    end
  end

end
