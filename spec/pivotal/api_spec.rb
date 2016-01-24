require 'spec_helper'

describe Pivotal::API do
  describe '.initialize' do
    it 'sets instance variables from the provided arguments' do
      args = { project_id: 123456789 }
      api = Pivotal::API.new(args)
      expect(api.instance_variable_get(:'@project_id')).to eq args[:project_id]
    end
  end
end
