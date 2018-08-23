require 'spec_helper'
require 'multi_json'

RSpec.describe Rickai::Client do
  let(:client) { Rickai::Client.new('AGENT_URL') }

  def api_uri(path)
    "https://exchange.appcraft.ru/transactions/AGENT_URL/#{path}"
  end

  describe '#actions' do
    let(:body) { { :transaction_id => 5 } }

    it 'updates' do
      stub_request(:post, api_uri('update'))
        .with(
          body: MultiJson.dump(body),
          headers: {
            'Content-Type' => 'application/json'
          }
        )
        .to_return(status: 200, body: '', headers: {})

      client.update(body)
    end

    it 'creates' do
      stub_request(:post, api_uri('create'))
        .with(
          body: MultiJson.dump(body),
          headers: {
            'Content-Type' => 'application/json'
          }
        )
        .to_return(status: 200, body: '', headers: {})

      client.create(body)
    end

    it "raises an error if POST doesn't return a 2xx response code" do
      stub_request(:post, api_uri('update'))
        .with(
          body: MultiJson.dump(body),
          headers: {
            'Content-Type' => 'application/json'
          }
        )
        .to_return(status: 500, body: '', headers: {})

      expect(-> { client.update(body) }).to raise_error(Rickai::Client::InvalidResponse)
    end
  end
end
