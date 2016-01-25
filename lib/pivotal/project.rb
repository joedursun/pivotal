require 'pivotal/story'

module Pivotal
  class Project < API

    class << self
      def update_for_release(release_label)
        stories = accepted_unreleased_stories
        if stories.empty?
          puts 'No stories found'
          return
        end

        release = Release.new(label: release_label, stories: stories)
        release.add_label_to_stories
        release.create_new_marker
      end

      def accepted_unreleased_stories
        most_recent = Release.most_recent
        return [] if most_recent.nil?

        filters = { after_story_id: most_recent.id, with_state: :accepted }
        Story.where(filters).select {|s| s.story_type != 'release'}
      end

      def endpoint
        '' # Request.base_url includes the project id so nothing to add here
      end
    end

  end
end
