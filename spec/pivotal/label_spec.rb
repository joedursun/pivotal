require 'spec_helper'

describe Pivotal::Label do
  describe '.endpoint' do
    it 'is the string "labels"' do
      expect(described_class.endpoint).to eq 'labels'
    end
  end

  describe '#endpoint' do
    it 'is the string "stories"' do
      expect(described_class.new.endpoint).to eq 'labels'
    end
  end
end
