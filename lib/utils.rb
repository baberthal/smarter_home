module Utils
  module MethodLogger
    def log_method(klass, method_name)
      klass.class_eval do
        alias_method "#{method_name}_original", method_name
        define_method method_name do |*args, &block|
          _logger "#{Time.zone.now}: Called #{method_name}"
          _logger "Arguments: #{args.join("\n")}"
          _logger "Block Given: #{block.inspect}" if block_given?
          send "#{method_name}_original", *args, &block
        end
      end
    end

    def _logger(message)
      if defined?(Rails.logger)
        Rails.logger.send(:info, message)
      else
        $stdout.send(:puts, message)
      end
    end
  end
end
