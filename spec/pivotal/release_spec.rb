require 'spec_helper'

describe Pivotal::Release do
  let(:story){ double('Story1', add_label: true) }
  let(:release){ described_class.new(label: 'Epic new release', stories: [story]) }

  describe '#create_new_marker' do
    it 'creates a new release story with the given name' do
      expect(described_class).to receive(:create)
                                .with({ name: release.marker_name, current_state: :accepted, story_type: 'release' })
                                .and_return({})
      release.create_new_marker
    end
  end

  describe '#add_label_to_stories' do
    it 'adds a label to each of the stories' do
      expect(story).to receive(:add_label).with('epic_new_release')
      release.add_label_to_stories
    end
  end

  describe '#marker_name' do
    it 'is the capitalized name without underscores' do
      release = described_class.new(label: 'hot_fix', stories: [story])
      expect(release.marker_name).to eq 'Hot fix'
    end
  end

  describe '.most_recent' do

  end
end
