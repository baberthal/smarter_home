module Services
  module Nest
    module Decorators
      class Device < Fabulous::Decorator
        def initialize(*args)
          super(*args)
        end

        def temp_scale
          @temp_scale ||= @object.stats['temperature_scale'].downcase
        end

        def hvac_mode
          @object.stats['hvac_mode']
        end

        def nest_leaf?
          @object.stats['has_leaf']
        end

        def current_ambient
          _scaled_attr(:ambient_temperature)
        end

        def humidity
          _scaled_attr(:humidity)
        end

        def current_target
          case hvac_mode
          when 'heat'
            _target_temp(:high)
          when 'cool'
            _target_temp(:low)
          when 'heat_cool'
            _target_temp(:high, :low)
          end
        end

        def current_target_formatted
          "#{current_target}&deg;".html_safe
        end

        def _scaled_attr(attrb)
          device_attr = attrb.to_s.insert(-1, %(_#{temp_scale}))
          @object.stats["#{device_attr}"]
        end

        def target_temp_type
          case @object.stats['hvac_mode']
          when 'heat', 'cool' then "_#{temp_scale}"
          when 'heat-cool' then ["_high_#{temp_scale}", "_low_#{temp_scale}"]
          end
        end

        def current_target
          case target_temp_type
          when String
            @object.stats["target_temperature#{target_temp_type}"]
          when Array
            ret = []
            target_temp_type.each do |temp_type|
              ret << @object.stats["target_temperature#{temp_type}"]
            end
            ret
          end
        end
      end
    end
  end
end
