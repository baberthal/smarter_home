require 'active_model'

module Services
  module Nest
    class Device
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON
      attr_accessor :name
      attr_reader :id, :structure_id, :name, :stats, :device_type
      def initialize(options = {})
        @id ||= options.delete(:id)
        @name ||= options[:stats]['name']
        @structure_id ||= options[:stats]['structure_id']
        @stats ||= options[:stats]
        @device_type ||= options[:device_type]
        @interface ||= options[:interface]
      end

      def decorate
        Services::Nest::Decorators::Device.new self
      end

      def attributes
        {
          'id' => id,
          'name' => name,
          'structure_id' => structure_id,
          'device_type' => device_type,
          'stats' => stats
        }
      end
    end
  end
end
