module Pivotal
  class ApiError < StandardError

    def initialize(opts={})
      opts.each_pair do |attribute, value|
        self.instance_variable_set("@#{attribute}", value)
      end
    end

  end
end
