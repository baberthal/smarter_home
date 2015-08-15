require 'spec_helper'
require 'shared/decorator_shared_spec'

Dummy = Struct.new(:stats)

RSpec.describe Services::Nest::Decorators::Device do
  it_behaves_like 'a decorator', described_class
  let(:device) { Dummy.new(read_json('nest/device_parsed.json')) }
  let(:decorator) { described_class.new(device) }

  describe '#current_ambient' do
    it 'sets up the device properly' do
      expect(device.stats['has_leaf']).to be_truthy
    end

    it 'sets the scale for the device' do
      expect(decorator.temp_scale).to eq 'c'
    end

    it 'returns the current ambient temp for the device' do
      expect(decorator.current_ambient).to eq 21.5
    end
  end

  describe '#target_temp' do
    context 'when the hvac_mode is heat' do
      before :each do
        device.stats['hvac_mode'] = 'heat'
      end

      it 'returns the proper target temp type' do
        expect(decorator.target_temp_type).to eq '_c'
      end

      it 'returns the proper temperature' do
        expect(decorator.current_target).to eq 21.5
      end
    end

    context 'when the hvac_mode is cool' do
      before :each do
        device.stats['hvac_mode'] = 'cool'
      end

      it 'returns the proper target temp type' do
        expect(decorator.target_temp_type).to eq '_c'
      end

      it 'returns the proper temperature' do
        expect(decorator.current_target).to eq 21.5
      end
    end

    context 'when the hvac_mode is heat-cool' do
      before :each do
        device.stats['hvac_mode'] = 'heat-cool'
      end

      it 'returns the proper target temp type' do
        expect(decorator.target_temp_type).to eq %w(_high_c _low_c)
      end

      it 'returns the proper temperature' do
        expect(decorator.current_target).to eq [21.5, 17.5]
      end
    end
  end
end
