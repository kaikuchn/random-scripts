# frozen_string_literal: true

module Chainable
  def self.included(other)
    other.instance_exec do
      @__chain = []
    end
  end

  module ClassMethods
    def add(callable, args)
      @__chain.unshift([callable, args])
    end

    def chainable(method_name, *arguments)
      dup.tap do |copy|
        copy.add(method(method_name), arguments)
      end
    end

    def call_chain(block, *args)
      @__chain.inject(-> { block.call(*args) }) do |callable, (m, m_args)|
        ->(*_args) { m.call(m_args, &callable) }
      end
    end
  end
end

# -----

def foo(*args, &block)
  return chainable(__method__, *args) if block.nil?

  call_chain(block, args.sum)
end
