require 'spec_helper'

RSpec.describe Services::Nest::Interface do
  let(:client) do
    instance_double('NestAPI::Client')
  end
  let(:structure_response) do
    JSON.parse(File.read('spec/support/nest/structure.json'))
  end
  let(:device_response) do
    JSON.parse(File.read('spec/support/nest/device.json'))
  end

  before do
    allow(client).to receive_messages(
      devices: device_response,
      structures: structure_response
    )
  end

  describe '#new' do
    let(:interface) { described_class.new(client) }
    it 'properly initializes' do
      expect(interface.devices).to_not be_empty
    end
  end
end
