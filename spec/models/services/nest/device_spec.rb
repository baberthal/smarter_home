require 'spec_helper'

RSpec.describe Services::Nest::Device do
  let(:device) do
    described_class.new(
      id: '1234567890',
      stats: {
        'name' => 'Bedroom',
        'structure_id' => Faker::Number.hexadecimal(10)
      },
      device_type: 'Thermostat'
    )
  end

  describe '#new' do
    it 'properly initializes the properties with the options passed' do
      expect(device.id).to eq '1234567890'
      expect(device.name).to eq 'Bedroom'
      expect(device.device_type).to eq 'Thermostat'
    end
  end

  describe '#decorate' do
    before do
      allow(Services::Nest::Decorators::Device)
        .to receive(:new).and_call_original
    end

    it 'initializes a decorator and returns it' do
      expect(device.decorate).to be_a Services::Nest::Decorators::Device
    end
  end
end
