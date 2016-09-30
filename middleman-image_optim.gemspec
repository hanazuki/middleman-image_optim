# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/image_optim/version'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-image_optim'
  spec.version       = Middleman::ImageOptim::VERSION
  spec.authors       = ['Kasumi Hanazuki']
  spec.email         = ['kasumi@rollingapple.net']

  spec.summary       = %q{Automatic image optimizer for Middleman}
  spec.description   = %q{Optimizes images during middleman build using image_optim gem}
  spec.homepage      = 'https://github.com/hanazuki/middleman-image_optim'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split(?\0).reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'middleman-core', '~> 4.0'
  spec.add_dependency 'image_optim', '~> 0.24'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rack-test', '~> 0.6.3'

  spec.add_development_dependency 'middleman', '~> 4.0'
  spec.add_development_dependency 'image_optim_pack', '~> 0.3.0'

  spec.requirements << 'Image optimizers of your choice or "image_optim_pack" gem'
end
