require 'spec_helper'

describe Wisper::Testing do
  it 'has a version number' do
    expect(Wisper::Testing::VERSION).not_to be nil
  end

  before do
    Wisper.configuration.broadcasters.clear
  end

  let(:publisher_class) { Class.new { include Wisper::Publisher } }
  let(:publisher) { publisher_class.new }
  let(:subscriber) { double('Subscriber') }

  describe '#fake!' do
    it 'ensures listener does not receive events' do
      Wisper.configuration.broadcaster(:default, Wisper::Broadcasters::SendBroadcaster.new)

      described_class.fake!

      event_name = 'foobar'

      publisher.subscribe(subscriber)

      expect(subscriber).not_to receive(event_name)
      expect(subscriber).to respond_to(event_name)

      publisher.send(:broadcast, event_name)
    end

    it 'sets fake broadcaster for all broadcaster keys' do
      Wisper.configuration.broadcaster(:default, double)
      Wisper.configuration.broadcaster(:async,   double)

      described_class.fake!

      expect(Wisper.configuration.broadcasters[:default]).to an_instance_of(Wisper::Testing::FakeBroadcaster)
      expect(Wisper.configuration.broadcasters[:async]).to an_instance_of(Wisper::Testing::FakeBroadcaster)
    end
  end

  describe '#inline!' do
    it 'uses default broadcaster for all events' do

    end
  end

  describe '#restore!' do
    it 'restores all broadcasters' do

    end
  end

  describe '#faking?' do
    describe 'when faking' do

    end

    describe 'when not faking' do

    end
  end

  describe 'when faking' do
    before { Testing::Wisper.fake! }


  end

  describe 'when inline' do

  end

end
