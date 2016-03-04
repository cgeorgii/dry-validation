require 'dry/validation/schema/dsl'

module Dry
  module Validation
    class Schema
      class Key < DSL
        def class
          Key
        end

        def to_ast
          [:key, [name, super]]
        end

        private

        def method_missing(meth, *args, &block)
          predicate = [:predicate, [meth, args]]

          if block
            val = Value[name].instance_eval(&block)
            add_rule(create_rule([:and, [[:val, predicate], val.to_ast]]))
          else
            rule = create_rule([:key, [name, predicate]])
            add_rule(rule)
            rule
          end
        end
      end
    end
  end
end
