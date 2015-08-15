module Services
  module Nest
    class Structure
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON
      attr_accessor :devices
      attr_reader :id, :name, :country_code, :away, :stats
      def initialize(structure_id, structure_stats, options = {})
        @interface = options[:interface]
        @id = structure_id
        get_attributes structure_stats
        @devices = []
        @interface.devices.select { |d| d.structure_id == @id }
      end

      def away?
        @away == 'away'
      end

      def home?
        @away == 'home'
      end

      def decorate
        Services::Nest::Decorators::Structure.new self
      end

      def attributes
        {
          'id' => id,
          'name' => name,
          'country_code' => country_code,
          'away' => away,
          'stats' => stats,
          'devices' => devices
        }
      end

      private

      def get_attributes(attribute_hash)
        @name = attribute_hash['name']
        @country_code = attribute_hash['country_code']
        @away = attribute_hash['away']
        @stats = attribute_hash
      end
    end
  end
end
