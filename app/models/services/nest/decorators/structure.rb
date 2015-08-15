module Services
  module Nest
    module Decorators
      class Structure
        def initialize(structure)
          @structure = structure
        end

        def html_id
          @structure.name.parameterize
        end

        def name
          @structure.name.titleize
        end

        def away_header
          header = <<-HTML
          <span id='#{@structure.away}' class='glyphicon glyphicon-home'>
          </span>
          HTML
          header.html_safe
        end

        def wheres
          @structure.stats['wheres']
        end

        def thermostats
          @structure.thermostats
        end

        def method_missing(meth, *args)
          if @structure.respond_to? meth
            @structure.send meth, *args
          else
            super
          end
        end

        def respond_to?(meth)
          @structure.respond_to? meth
        end
      end
    end
  end
end
