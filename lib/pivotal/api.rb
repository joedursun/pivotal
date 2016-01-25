require 'pivotal/request'

module Pivotal
  class API
    attr_reader :error, :code, :general_problem

    def initialize(opts={})
      opts.each_pair do |attribute, value|
        self.instance_variable_set("@#{attribute}", value)
      end
    end

    def endpoint
      self.class.endpoint
    end

    def errors?
      !error.nil?
    end

    def self.endpoint
      raise 'You must define an endpoint in the child class.'
    end

    def self.where(filters={})
      objects = Request.get(endpoint, filters) || []
      objects.map {|s| self.new(s)}
    end

    def self.create(opts)
      response = Request.post(endpoint, opts)
      self.new(response)
    end
  end

end
