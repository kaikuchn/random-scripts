# frozen_string_literal: true

module Measure
  module_function

  def measure(name = ?**160)
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    yield
  ensure
    duration = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
    puts name.center(160, ?*)
    puts "*#{duration.round(3).to_s.center(158)}*"
    puts ?**160
  end

  def profile
    ret_val = nil
    result = RubyProf.profile { ret_val = yield }
    RubyProf::GraphPrinter.new(result).print(STDOUT, min_percent: 5)

    ret_val
  end
end
