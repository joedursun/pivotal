require 'pivotal/story'

module Pivotal
  class Release < Story
    attr_reader :stories, :label

    def marker_name
      label.capitalize.gsub('_', ' ')
    end

    def create_new_marker
      opts = { name: marker_name, current_state: :accepted, story_type: 'release' }
      self.class.create(opts)
    end

    def add_label_to_stories(label=nil)
      label ||= name
      stories.each do |story|
        story.add_label(label)
      end
    end

    def self.most_recent(days_since_last_release=nil)
      search_from_date = search_interval(days_since_last_release)
      filters = {with_state: :accepted, with_story_type: :release, accepted_after: search_from_date}
      self.where(filters).sort_by(&:accepted_at).last
    end

    private

    def self.search_interval(num_days)
      num_days ||= 14
      past_date = Time.now - 60*60*24*(num_days+1)
      Time.at(past_date).utc.iso8601
    end
  end
end
