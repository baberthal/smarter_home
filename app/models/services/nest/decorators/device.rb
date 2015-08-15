require 'lib/fabulous/decorator'

module Services
  module Nest
    module Decorators
      class Device < Fabulous::Decorator
        alias_method :device, :object

        def stats_hash_for
        end

        def nest_leaf?
          if @device.stats['has_leaf']

          end
        end

        # def method_missing(meth, *args)
        #   if @device.respond_to? meth
        #     @device.send meth, *args
        #   else
        #     super
        #   end
        # end

        # def respond_to?(meth)
        #   @device.respond_to? meth
        # end
      end
    end
  end
end
