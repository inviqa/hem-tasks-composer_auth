# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'hem/tasks/composer-auth/version'

Gem::Specification.new do |spec|
  spec.name          = 'hem-tasks-composer-auth'
  spec.version       = Hem::Tasks::ComposerAuth::VERSION
  spec.authors       = ['Kieren Evans']
  spec.email         = ['kevans+hem_tasks@inviqa.com']

  spec.summary       = 'Composer Authentication task for Hem'
  spec.description   = 'Composer Authentication task for Hem'
  spec.homepage      = ''
  spec.licenses = ['MIT']

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|\.rubocop\.yml|Rakefile)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.55.0'
end
