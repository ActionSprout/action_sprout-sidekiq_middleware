# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_sprout/sidekiq_middleware/version'

Gem::Specification.new do |spec|
  spec.name          = 'action_sprout-sidekiq_middleware'
  spec.version       = ActionSprout::SidekiqMiddleware::VERSION
  spec.authors       = ['Amiel Martin']
  spec.email         = ['amiel@actionsprout.com']

  spec.summary       = %q{ActionSprout Sidekiq Middleware}
  spec.description   = %q{This gem includes various Sidekiq Middleware used at ActionSprout.}
  spec.homepage      = 'https://github.com/ActionSprout/action_sprout-sidekiq_middleware'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']


  spec.add_development_dependency 'activesupport', '> 4'
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
end
