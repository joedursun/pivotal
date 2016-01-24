require 'spec_helper'

describe Pivotal::Request do
  describe '.base_url' do
    it 'raises an error if project id env var is not set' do
      described_class::PROJECT = nil
      expect { described_class.base_url }.to raise_error(StandardError)
    end
  end

  describe '.get' do

  end

  describe '.post' do

  end

  describe '.create_post_request' do

  end
end
