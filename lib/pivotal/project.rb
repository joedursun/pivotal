require 'pivotal/story'

module Pivotal
  class Project

    class << self
      def update_for_release(release_label)
        stories = delivered_unreleased_stories
        if stories.empty?
          puts 'No stories found'
        end

        add_release_label_to_stories(stories, release_label)
        after_id = stories.sort_by(&:accepted_at).last.id

        marker_name = release_label.capitalize.gsub('_', ' ')
        create_new_release_marker(marker_name)
      end

      def create_new_release_marker(name)
        opts = { name: name, current_state: :accepted, story_type: 'release'}
        Story.create(opts)
      end

      def add_release_label_to_stories(stories, label_name)
        stories.each do |story|
          story.add_label(label_name)
        end
      end

      def last_release_id
        date = Time.at(2.weeks.ago).utc.iso8601
        filters = {with_state: :accepted, with_story_type: :release, accepted_after: date}
        Story.where(filters).sort_by(&:accepted_at).last.id
      end

      def delivered_unreleased_stories
        filters = { after_story_id: last_release_id, with_state: :accepted }
        Story.where(filters).select {|s| s.story_type != 'release'}
      end
    end

  end
end
