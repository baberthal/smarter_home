require 'rails_helper'
require 'app/helpers/user_services_helper'

DummyDevice = Struct.new(:name, :stats)

RSpec.describe UserServicesHelper, type: :helper do
  described_class
  describe '#class_for_away' do
    context 'when home' do
      it 'returns the proper class' do
        expect(class_for_away('home')).to eq 'panel-nest-home'
      end
    end

    context 'when away' do
      it 'returns the proper class' do
        expect(class_for_away('away')).to eq 'panel-nest-away'
      end
    end

    context 'something else' do
      it 'returns the proper class' do
        expect(class_for_away('foo')).to eq 'foo'
      end
    end
  end

  describe 'status_class_for' do
    context 'when the mode is cool' do
      let(:dummy_device) { DummyDevice.new('dummy', 'hvac_state' => 'cool') }
      it 'returns the proper class' do
        expect(status_class_for(dummy_device)).to eq 'cool'
      end
    end

    context 'when the mode is heat' do
      let(:dummy_device) { DummyDevice.new('dummy', 'hvac_state' => 'heat') }
      it 'returns the proper class' do
        expect(status_class_for(dummy_device)).to eq 'heat'
      end
    end

    context 'when the mode is heat-cool' do
      let(:dummy_device) { DummyDevice.new('dumb', 'hvac_state' => 'heat-cool') }
      it 'returns the proper class' do
        expect(status_class_for(dummy_device)).to eq 'heat-cool'
      end
    end
  end
end
