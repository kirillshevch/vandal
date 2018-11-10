lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vandal/version'

Gem::Specification.new do |spec|
  spec.name          = 'vandal'
  spec.version       = Vandal::VERSION
  spec.authors       = ['Kirill Shevchenko']
  spec.email         = ['hello@kirillshevch.com']

  spec.summary       = 'ActiveRecord force destroy record with associations.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/kirillshevch/vandal'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry-byebug'
end
