require 'pivotal/request'

module Pivotal
  class API

    def self.endpoint
      raise 'You must define an endpoint in the child class.'
    end

    def endpoint
      self.class.endpoint
    end

    def initialize(opts={})
      opts.each_pair do |attribute, value|
        self.instance_variable_set("@#{attribute}", value)
      end
    end

    def self.where(filters={})
      objects = Request.get(endpoint, filters) || []
      objects.map {|s| self.new(s)}
    end

    def self.create(opts)
      Request.post(endpoint, opts)
    end
  end

end
