# ActionSprout::SidekiqMiddleware

This gem includes various Sidekiq Middleware used at ActionSprout.

## Installation

Add this line to your application's Gemfile:

```ruby
# make sure gemfury source is also in this file.
gem 'action_sprout-sidekiq_middleware'
```

And then execute:

    $ bundle

## Usage

### BugSnag Filters

In your Sidekiq config, add the `BugsnagFilters` middleware with the `SidekiqRetry` filter:

```ruby
Sidekiq.configure_server do |config|
  ...

  config.server_middleware do |chain|
    chain.add ActionSprout::SidekiqMiddleware::BugsnagFilters, filters: [ActionSprout::BugsnagFilters::SidekiqRetry]

    ...
  end
end
```

## Development

#### Setup

1. Check out repo `https://github.com/ActionSprout/action_sprout-sidekiq_middleware.git`
2. `bin/setup` (this runs `bundle install`)
3. Run tests with `rake spec`

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

**Use locally**
To install this gem into a local project add to your Gemfile
```ruby
gem 'action_sprout-sidekiq_middleware', path: 'relative/path/to/gem/repo'
```
and then `bundle install` in that project. Remember to add the Gemfury `source` before
using in production.

#### Release a new Version

Update the version number in `lib/action_sprout/sidekiq_middleware/version.rb` and make your final version change commit.
Create a release tag with `gem_push=no rake release`.

Make sure you have the git remote `fury` added. See the [Gemfury docs](https://manage.fury.io/dashboard/actionsprout/repos/ruby/push) for more information.

    $ git remote add fury https://PASSWORD@repo.fury.io/ORGANIZATION/


To release the new verison we push to our Gemfury repo. Gemfury requires we update their `master` ref.

    $ git push fury main:master
