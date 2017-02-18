# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nevzorov'

Gem::Specification.new do |spec|
  spec.name          = 'nevzorov'
  spec.version       = Nevzorov::VERSION
  spec.authors       = ['Tema Bolshakov']
  spec.email         = ['abolshakov@spbtv.com']

  spec.summary       = 'Generates Alexander Nevzorov podcast feed'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '3.5.0'
  spec.add_development_dependency 'rubocop', '0.47.1'
  spec.add_runtime_dependency 'dry-configurable', '0.6.0'
  spec.add_runtime_dependency 'nokogiri', '1.7.0.1'
  spec.add_runtime_dependency 'thor', '0.19.4'
  spec.add_runtime_dependency 'vcr', '3.0.3'
end
