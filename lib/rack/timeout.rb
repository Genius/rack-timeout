require RUBY_VERSION < '1.9' && RUBY_PLATFORM != 'java' ? 'system_timer' : 'timeout'
SystemTimer ||= Timeout

module Rack
  class Timeout
    @timeout = 15
    class << self
      attr_accessor :timeout
    end

    Error = Class.new(StandardError)

    def initialize(app)
      @app = app
    end

    def call(env)
      SystemTimer.timeout(self.class.timeout, Error) { @app.call(env) }
    end

  end
end
