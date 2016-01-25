require 'spec_helper'

describe Pivotal::API do
  describe '.initialize' do
    it 'sets instance variables from the provided arguments' do
      args = { project_id: 123456789 }
      api = Pivotal::API.new(args)
      expect(api.instance_variable_get(:'@project_id')).to eq args[:project_id]
    end
  end

  describe '.endpoint' do
    it 'raises an error warning for it to be set in child classes' do
      expect {described_class.endpoint}.to raise_error(StandardError)
    end
  end

  describe '#errors?' do
    it 'is false when Pivotal responds without an error message' do
      expect(described_class.new.errors?).to eq false
    end

    it 'is true when Pivotal responds with an error message' do
      obj = described_class.new(error: 'One or more request parameters was missing or invalid.')
      expect(obj.errors?).to be true
    end
  end
end
