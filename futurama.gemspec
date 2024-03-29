# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'futurama/version'

Gem::Specification.new do |spec|
  spec.name          = "futurama"
  spec.version       = Futurama::VERSION
  spec.authors       = ["Carsten Dreesbach"]
  spec.email         = ["carsten.dreesbach@oracle.com"]

  spec.summary       = %q{A simplistic implementation of Futures, based on https://www.sitepoint.com/learn-concurrency-by-implementing-futures-in-ruby/.}
  spec.description   = %q{Yeah, really nothing more to say here...}
  spec.homepage      = "https://github.com/herbcso/futurama"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://gemserver.va.opower.it"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", '~> 1.56.0'
  spec.add_development_dependency "pry", '~> 0.14.0'
end
