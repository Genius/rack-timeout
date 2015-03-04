require_relative '../lib/rack/timeout'

describe Rack::Timeout do
  let(:timeout) { 1 }

  before { Rack::Timeout.timeout = timeout }

  subject { Rack::Timeout.new(app).call({}) }

  context 'when timing out' do
    let(:app) { ->(e) { sleep timeout + 1 } }

    it 'should raise Rack::Timeout::Error' do
      expect { subject }.to raise_error(Rack::Timeout::Error)
    end
  end

  context 'when not timing out' do
    let(:app) { ->(e) { nil } }

    it 'should not raise' do
      expect(subject).to be_nil
    end
  end
end
