require 'rails_helper'

RSpec.describe Services::Nest::Structure do
  let(:client) { instance_double('NestAPI::Client') }
  let(:interface) do
    instance_double('Services::Nest::Interface', client: client)
  end

  before do
    allow(interface).to receive_messages(
      devices: devices
    )
  end

  let(:devices) do
    [
      instance_double(
        'Services::Nest::Device',
        structure_id: '12345678890'
      )
    ]
  end

  let(:structure) do
    described_class.new(
      '1234567890',
      {
        'name' => 'Test Home1',
        'country_code' => 'US',
        'away' => 'home'
      },
      interface: interface
    )
  end

  describe '#new' do
    it 'properly initializes the properties with the options passed' do
      expect(structure.id).to eq '1234567890'
      expect(structure.name).to eq 'Test Home1'
      expect(structure.country_code).to eq 'US'
      expect(structure.away).to eq 'home'
    end
  end

  describe '#decorate' do
    before do
      allow(Services::Nest::Decorators::Structure)
        .to receive(:new).and_call_original
    end

    it 'initializes a decorator and returns it' do
      expect(structure.decorate).to be_a Services::Nest::Decorators::Structure
    end
  end

  describe 'string inquirers' do
    after :each do
      structure.instance_variable_set(:@away, nil)
    end

    context 'when home' do
      before :each do
        structure.instance_variable_set(:@away, 'home')
      end

      it 'away? returns false' do
        expect(structure.away?).to be_falsy
      end

      it 'home? returs true' do
        expect(structure.home?).to be_truthy
      end
    end

    context 'when away' do
      before :each do
        structure.instance_variable_set(:@away, 'away')
      end

      it 'home? returns false' do
        expect(structure.home?).to be_falsy
      end

      it 'away? returs true' do
        expect(structure.away?).to be_truthy
      end
    end
  end
end
