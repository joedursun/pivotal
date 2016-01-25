require 'pivotal/story'

module Pivotal
  class Project < API
    attr_reader :version, :iteration_length, :week_start_day, :point_scale, :point_scale_is_custom,
                :bugs_and_chores_are_estimatable, :automatic_planning, :enable_tasks, :start_date,
                :time_zone, :velocity_averaged_over, :shown_iterations_start_time, :start_time,
                :number_of_done_iterations_to_show, :has_google_domain, :description, :profile_content,
                :enable_incoming_emails, :initial_velocity, :project_type, :public, :atom_enabled,
                :current_iteration_number, :current_velocity, :current_volatility, :account_id,
                :story_ids, :epic_ids, :membership_ids, :label_ids, :integration_ids, :iteration_override_numbers

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
