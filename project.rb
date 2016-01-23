require 'pivotal/story'

module Pivotal
  class Project

    class << self
      def update_for_release(release_label)
        stories = delivered_unreleased_stories
        add_release_label_to_stories(stories, release_label)
        after_id = stories.sort_by(&:accepted_at).last.id

        marker_name = release_label.capitalize.gsub('_', ' ')
        create_new_release_marker(marker_name, after_id)
      end

      def create_new_release_marker(name, after_id=nil)
        opts = { name: name, accepted_at: Time.now.utc.iso8601, story_type: 'release', after_id: after_id }
        opts.delete_if {|k,v| v.nil?}

        Story.create(opts)
      end

      def add_release_label_to_stories(stories, label_name)
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
        Story.where(filters).select {|s| s.story_type != 'release'}
      end
    end

  end
end
