# frozen_string_literal: true

module ActionSprout
  module SidekiqMiddleware
    class BugsnagFilters
      def initialize(filters: )
        @filters = filters
      end

      attr_reader :filters, :callback

      def call(_worker, job, _queue)
        callback = lambda do |notification|
          filters.each { |filter| filter.call notification, job }
          Bugsnag.before_notify_callbacks.delete callback
        end

        Bugsnag.before_notify_callbacks << callback
        yield
      end
    end
  end
end
