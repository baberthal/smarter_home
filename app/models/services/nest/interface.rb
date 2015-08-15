module Services
  module Nest
    class Interface
      attr_reader :client, :user
      attr_accessor :structures, :devices, :decorator
      def initialize(client)
        @client = client
        @devices = []
        @structures = []
        parse_client
      end

      def add_structure(structure_id, stats)
        @structures << Structure.new(structure_id, stats, interface: self)
      end

      def parse_client
        @client.structures.each { |s, st| add_structure(s, st) }
        iterate_devices @client.devices
      end

      def iterate_devices(device_hash)
        device_hash.each do |device_type, devices|
          devices.each do |id, stats|
            @devices << Device.new(id: id,
                                   stats: stats,
                                   device_type: device_type,
                                   interface: self)
          end
        end
      end

      def decorate
        return unless @decorator.nil?
        @decorator = Services::Nest::Decorators::Interface.new self
        @decorator
      end

      def decorate!
        @decorator = Services::Nest::Decorators::Interface.new self
        @decorator
      end
    end
  end
end
