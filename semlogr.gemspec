lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'semlogr/version'

Gem::Specification.new do |spec|
  spec.name          = 'semlogr'
  spec.version       = Semlogr::VERSION
  spec.authors       = ['Stefan Sedich']
  spec.email         = ['stefan.sedich@gmail.com']

  spec.summary       = 'Semantic logging for Ruby'
  spec.description   = 'A modern semantic logger for Ruby inspired by Serilog.'
  spec.homepage      = 'https://github.com/semlogr/semlogr'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'digest-xxhash', '~> 0.1'
  spec.add_dependency 'lru_redux', '~> 1.1'
  spec.add_dependency 'oj', '~> 3.5'

  spec.add_development_dependency 'benchmark-ips', '~>2.7'
  spec.add_development_dependency 'benchmark-memory', '~>0.1'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '0.53'
  spec.add_development_dependency 'simplecov', '~>0.15'
end
