require 'active_model/serialization'
require 'active_model/serializers/json'
require 'active_model/serializers/xml'

module Fabulous
  class Decorator
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml

    attr_reader :object
    alias_method :model, :object

    def initialize(object, options = {})
      options.assert_valid_keys(:context)
      @object = object
      @context = options.fetch(:context, {})
    end

    class << self
      alias_method :decorate, :new
    end

    def method_missing(meth, *args)
      if @object.respond_to? meth
        @object.send meth, *args
      else
        super
      end
    end

    def respond_to?(meth)
      @object.respond_to? meth
    end
  end
end
