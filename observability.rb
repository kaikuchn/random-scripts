module Observability
  def self.included(mod)
    mod.instance_variable_set(:@__context, mod)
    mod.extend(ClassMethods)
  end

  module ClassMethods
    def observe(method_name)
      if instance_method?(method_name)
        observe_instance_method(method_name)
      elsif singleton_method?(method_name)
        observe_singleton_method(method_name)
      else
        raise 'wat?'
      end
    end

    private

    def instance_method?(method_name)
      return false unless @__context.respond_to?(:instance_methods)
      @__context.instance_methods.include?(method_name)
    end

    def singleton_method?(method_name)
      @__context.singleton_methods.include?(method_name)
    end

    def observe_instance_method(method_name)
      original = @__context.instance_method(method_name)
      logging = method(:with_entry_and_exit_logging)

      @__context.define_method(method_name) do |*args|
        logging.call(method_name, self, args) do
          original.bind(self).call(*args)
        end
      end
    end

    def observe_singleton_method(method_name)
      original = @__context.singleton_method(method_name)
      logging = method(:with_entry_and_exit_logging)

      @__context.define_singleton_method(method_name) do |*args|
        logging.call(method_name, self, args) do
          original.bind(self).call(*args)
        end
      end
    end

    def with_entry_and_exit_logging(method_name, context, args)
      puts "Start #{method_name} in #{context.class.inspect} #{context.object_id} : #{args.inspect}"
      result = yield
      puts "End #{method_name} in #{context.class.inspect} #{context.object_id} : #{args.inspect}"
      result
    end
  end
end

class Foo
  include Observability

  observe def bar(a, b)
    (a + b).tap { |x| puts x }
  end
end
