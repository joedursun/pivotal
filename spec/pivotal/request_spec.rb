require 'spec_helper'
require 'open-uri'

describe Pivotal::Request do
  describe '.base_url' do
    it 'raises an error if project id env var is not set' do
      stub_const("#{described_class}::PROJECT", nil)
      expect { described_class.base_url }.to raise_error(StandardError)
    end
  end

  describe '.get' do
    context 'with params' do
      let(:params){ {foo: :bar} }

      it 'url encodes the params' do
        url = described_class.base_url + '/stories?foo=bar'

        expect(described_class).to receive(:open).and_return({good: :job}.to_json)
        expect(described_class.get('stories', params)).to eq({'good' => 'job'})
      end
    end

    it 'executes a get request with a X-Token header' do
      url = described_class.base_url + '/stories'
      expect(described_class).to receive(:open)
                                 .with(url, {'X-TrackerToken' => described_class::TOKEN})
                                 .and_return({good: :job}.to_json)
      expect(described_class.get('stories')).to eq({'good' => 'job'})
    end
  end

  describe '.post' do
    let(:response){ double('Net::HTTPResponse', body: {good: :job}.to_json) }
    let(:uri){ URI(described_class.base_url + '/stories') }

    before(:each) do
      expect(Net::HTTP).to receive(:start)
                           .with(uri.host, uri.port, use_ssl:true)
                           .and_return(response)
    end

    it 'makes a post request to the pivotal api' do
      expect(described_class.post('stories', {foo: :bar})).to eq({"good"=>"job"})
    end
  end

  describe '.create_post_request' do
    let(:uri){ URI('https://example.com') }
    let(:params){ {foo: :bar} }

    it 'adds the pivotal tracker token as a request header' do
      request = described_class.create_post_request(uri, params)
      expect(request['X-TrackerToken']).to eq described_class::TOKEN
    end

    it 'adds a Content-Type request header' do
      request = described_class.create_post_request(uri, params)
      expect(request['Content-Type']).to eq 'application/json'
    end

    it 'puts the params hash in the request body' do
      request = described_class.create_post_request(uri, params)
      expect(request.body).to eq params.to_json
    end
  end
end
