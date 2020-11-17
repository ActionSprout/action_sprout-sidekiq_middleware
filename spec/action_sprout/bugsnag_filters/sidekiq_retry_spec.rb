# frozen_string_literal: true

require 'spec_helper'

require 'active_support/core_ext/hash/keys'

require 'action_sprout/bugsnag_filters/sidekiq_retry'

RSpec.describe ActionSprout::BugsnagFilters::SidekiqRetry, '.call' do
  before { described_class.call notification, sidekiq_job }

  let(:notification) { double('BugsnagNotification', ignore!: nil) }

  let(:retry_setting) { 25 }

  shared_examples 'does not ignore the notification' do
    it { expect(notification).to_not have_received(:ignore!).with(no_args) }
  end

  shared_examples 'ignores the notification' do
    it { expect(notification).to have_received(:ignore!).with(no_args) }
  end

  let(:sidekiq_job) { {
    retry: retry_setting,
    retry_count: retry_count,
  }.stringify_keys }

  context 'with a default sidekiq job that is on its first failure' do
    let(:retry_count) { 0 }
    include_examples 'ignores the notification'
  end

  context 'with a default sidekiq job that has no retry_count (I guess this happens on the first try)' do
    let(:retry_count) { nil }
    include_examples 'ignores the notification'
  end

  context 'with a default sidekiq job that is on its second failure' do
    let(:retry_count) { 1 }
    include_examples 'ignores the notification'
  end

  context 'with a default sidekiq job that is on its third failure' do
    let(:retry_count) { 2 }
    include_examples 'does not ignore the notification'
  end

  context 'with a default sidekiq job that is on its third failure' do
    let(:retry_count) { 2 }
    include_examples 'does not ignore the notification'
  end

  context 'with a no retry sidekiq job on its first failure' do
    let(:retry_setting) { false }
    let(:retry_count) { 0 }
    include_examples 'does not ignore the notification'
  end

  context 'with a no retry sidekiq job on its first failure' do
    let(:retry_setting) { nil }
    let(:retry_count) { 0 }
    include_examples 'does not ignore the notification'
  end

  context 'with a retry sidekiq job on its first failure' do
    let(:retry_setting) { true }
    let(:retry_count) { 0 }
    include_examples 'ignores the notification'
  end

  context 'with a retry sidekiq job on its second failure' do
    let(:retry_setting) { true }
    let(:retry_count) { 1 }
    include_examples 'ignores the notification'
  end

  context 'with a retry sidekiq job on its third failure' do
    let(:retry_setting) { true }
    let(:retry_count) { 2 }
    include_examples 'does not ignore the notification'
  end

  context 'with a low retry sidekiq job on its first failure' do
    let(:retry_setting) { 3 }
    let(:retry_count) { 0 }
    include_examples 'ignores the notification'
  end

  context 'with a low retry sidekiq job on its second failure' do
    let(:retry_setting) { 3 }
    let(:retry_count) { 1 }
    include_examples 'does not ignore the notification'
  end

  context 'with a high retry sidekiq job on its third failure' do
    let(:retry_setting) { 11 }
    let(:retry_count) { 2 }
    include_examples 'does not ignore the notification'
  end

  context 'with a 0 retry setting on the first failure' do
    let(:retry_setting) { 0 }
    let(:retry_count) { 0 }
    include_examples 'does not ignore the notification'
  end
end
