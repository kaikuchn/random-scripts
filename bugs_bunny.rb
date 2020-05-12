# frozen_string_literal: true

module BugsBunny
  module TransportSpy
    def read_next_frame(*)
      super.tap do |frame|
        puts frame.method_class if frame.respond_to?(:method_class)
        puts frame.decode_payload if frame.respond_to?(:decode_payload)
      end
    end
  end
end

Bunny::Transport.prepend(BugsBunny::TransportSpy)
