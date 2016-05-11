require 'spec_helper'

describe Pivotal::Epic do
  describe '.endpoint' do
    it 'is the epics endpoint' do
      expect(described_class.endpoint).to eql 'epics'
    end
  end

  describe '#label' do
    it 'is nil if the epic does not have a label' do
      expect(described_class.new.label).to be_nil
    end
  end
end
