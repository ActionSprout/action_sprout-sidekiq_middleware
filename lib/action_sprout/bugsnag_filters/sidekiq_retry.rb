# frozen_string_literal: true

module ActionSprout
  module BugsnagFilters
    class SidekiqRetry
      def self.call(notification, sidekiq_job)
        new(notification, sidekiq_job).filter
      end

      def initialize(notification, sidekiq_job)
        @notification = notification
        @sidekiq_job = sidekiq_job
      end

      def filter
        if should_ignore?
          notification.ignore!
        end
      end

      def should_ignore?
        retry_count < min_retry_count
      end

      private

      attr_reader :notification, :sidekiq_job

      def retry_count
        sidekiq_job['retry_count'] || 0
      end

      def retry_setting
        sidekiq_job['retry']
      end

      def min_retry_count
        case retry_setting
        when 1...9 then retry_setting
        when 10..Float::INFINITY, true then 2
        else 0
        end
      end
    end
  end
end
