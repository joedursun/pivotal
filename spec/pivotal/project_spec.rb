require 'spec_helper'

describe Pivotal::Project do
  describe '.update_for_release' do
    context 'no stories since last release' do
      it 'returns early' do
        expect(described_class).to receive(:accepted_unreleased_stories).and_return([])
        expect(Pivotal::Release).not_to receive(:new)

        described_class.update_for_release('new release label')
      end
    end
  end

  describe '.accepted_unreleased_stories' do
    let(:story){ Pivotal::Story.new(id: 1) }
    let(:recent_release){ Pivotal::Release.new(stories: [story]) }

    context 'could not find most recent release' do
      it 'returns an empty array' do
        expect(Pivotal::Release).to receive(:most_recent).and_return(nil)
        expect(described_class.accepted_unreleased_stories).to eq []
      end
    end

    context 'no stories have been accepted since last release' do
      it 'is an empty array' do
        expect(Pivotal::Release).to receive(:most_recent).and_return(recent_release)
        expect(Pivotal::Story).to receive(:where).and_return([])
        expect(described_class.accepted_unreleased_stories).to eq []
      end
    end
  end
end
