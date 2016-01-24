require 'pivotal/api'

module Pivotal
  class Label < API
    attr_reader :id, :project_id, :name, :created_at, :updated_at

    def endpoint
      'stories'
    end

  end
end
