module Services
  module Nest
    module Decorators
      class Interface
        attr_reader :first_device
        def initialize(interface)
          @interface = interface
          @first_device = @interface.devices.first
        end

        def method_missing(meth, *args)
          if @interface.respond_to? meth
            @interface.send meth, *args
          else
            super
          end
        end

        def respond_to?(meth)
          @interface.respond_to? meth
        end
      end
    end
  end
end
