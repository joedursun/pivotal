module Pivotal
  class Epic < API
    attr_reader :label_id, :description, :comment_ids, :follower_ids, :after_id, :before_id, :url

    def self.endpoint
      'epics'
    end

    def label
      Label.new(@label_id) if @label_id
    end

  end
end
