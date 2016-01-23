require 'pivotal/story'

module Pivotal
  class Project

    class << self
      def create_new_release_marker(name)
        Story.create('release', name)
      end

      def move_stories_above_release_marker

      end

      def add_release_label_to_stories(label_name)
        stories = get_delivered_and_unreleased_stories
        stories.each do |story|
          story.add_label(label_name)
        end
      end

      def last_release_id
        # FIXME
        112066197
      end

      def delivered_unreleased_stories
        filters = { after_story_id: last_release_id, with_state: :accepted }
        stories = Story.where(filters)
        stories.select {|s| s.story_type != 'release'}
      end
    end

  end
end
