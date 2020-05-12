# frozen_string_literal: true

require 'bundler'

Bundler.setup
require 'pathname'
require 'securerandom'
require 'ostruct'
require 'time'
require 'yaml'

class Rails
  def self.env
    'development'
  end

  def self.root
    Pathname.new(__FILE__).realpath.dirname
  end
end

$LOAD_PATH.unshift(Pathname.new(__FILE__).realpath.dirname + 'lib')
require_relative 'config/initializers/citus'

class Spammer
  def initialize(parallelization = 10)
    Citus.db # load citus connection in main thread
    names = Array.new(parallelization) { |i| "Thread ##{i}" }
    tenants = Array.new(parallelization) { SecureRandom.uuid }
    @thread_configs = names.zip(tenants).map.with_index do |(name, tenant), idx|
      OpenStruct.new(
        name: name,
        tenant: tenant,
        last_seen_at: Time.now - (NORMAL + 1), # initial state should be suspicious
        num: idx
      )
    end
    @queue = Queue.new
  end

  attr_reader :queue

  def call
    @stopping = false
    threads = @thread_configs.map do |t_conf|
      Thread.new do
        Thread.current.name = t_conf.name
        Thread.current[:thread_config] = t_conf
        run(t_conf.tenant)
      end
    end
    puts @thread_configs.map(&:name).join("\t")
    loop do
      sleep 1
      print_state
    end
  rescue Exception
    @stopping = true
    threads.each(&:join)
    raise
  end

  private

  def run(tenant)
    loop do
      break if @stopping
      with_retries { insert(tenant) }
      sleep Math.exp(rand)
    end
  end

  def with_retries(num = 5, backoff = ->(i) { Math.exp(5 - i) / 10 })
    yield
  rescue StandardError
    raise if num.zero?
    sleep backoff.call(num)
    num -= 1
    retry
  end

  def insert(tenant)
    result = Citus[:foo]
               .returning
               .insert(tenant: tenant, value: Time.now.iso8601(6))
    log(result)
  end

  IS_OK   = "\e[32m\u2713\e[0m"
  IS_LATE = "\e[33m?\e[0m"
  IS_DEAD = "\e[31m\u271D\e[0m"
  STATE_STRING_NON_PRINTABLE_SIZE = 9
  NORMAL     = 5
  SUSPICIOUS = 30
  def thread_state(last_seen_ago)
    return IS_OK if last_seen_ago < NORMAL
    return IS_LATE if last_seen_ago < SUSPICIOUS
    IS_DEAD
  end

  def print_state
    now = Time.now
    print "\e[0K\r"
    states = @thread_configs.map do |config|
      state = thread_state(now - config.last_seen_at)
      # OK, LATE & DEAD string size is not equal to the amount of padding needed
      # due to non-printable characters
      state.rjust(config.name.size + STATE_STRING_NON_PRINTABLE_SIZE)
    end
    print states.join("\t")
  end

  def log(result)
    Thread.current[:thread_config].last_seen_at = Time.now
    @queue << [Thread.current.name, result]
  end
end

Spammer.new.call
