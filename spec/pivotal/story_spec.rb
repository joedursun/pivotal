require 'spec_helper'

describe Pivotal::Story do
  describe '#labels' do
    let(:labels) do
      [
        {'id'=>123456789, 'project_id'=>1234567, 'kind'=>'label', 'name'=>'funky label',
         'created_at'=>'2015-11-23T20:59:37Z', 'updated_at'=>'2015-11-23T20:59:37Z'},
        {'id'=>987654321, 'project_id'=>7654321, 'kind'=>'label', 'name'=>'another label',
         'created_at'=>'2005-11-24T20:59:37Z', 'updated_at'=>'2005-11-24T20:59:37Z'},
      ]
    end

    context 'no associated labels' do
      it 'is an empty array' do
        story = described_class.new
        expect(story.labels).to eq []
      end
    end

    context 'has associated labels' do
      it 'is an array of label objects' do
        story = described_class.new(labels: labels)
        all_are_labels = story.labels.all? { |l| l.instance_of? Pivotal::Label }
        expect(all_are_labels).to eq true
      end
    end
  end

  describe '#add_label' do
    let(:label_response) do
      {
       'created_at': '2016-01-19T12:00:00Z',
       'id': 5100,
       'kind': 'label',
       'name': 'my new label',
       'project_id': 99,
       'updated_at': '2016-01-19T12:00:00Z'
      }
    end

    it 'adds a label to the story' do
      expect(Pivotal::Request).to receive(:post)
                              .with('stories/1/labels', {name: 'funky'})
                              .and_return(label_response)
      described_class.new(id: 1).add_label('funky')
    end
  end

  describe '.endpoint' do
    it 'is the string "stories"' do
      expect(described_class.endpoint).to eq 'stories'
    end
  end

  describe '#endpoint' do
    it 'is the string "stories"' do
      expect(described_class.new.endpoint).to eq 'stories'
    end
  end
end
