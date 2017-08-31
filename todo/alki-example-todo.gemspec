# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "alki-example-todo"
  spec.version       = "0.1.0"
  spec.authors       = ["Matt Edlefsen"]
  spec.email         = ["matt.edlefsen@gmail.com"]

  spec.summary       = %q{Example todo command line app built with alki}
  spec.homepage      = "https://github.com/alki-project/alki-examples"
  spec.license       = "MIT"

  spec.files         = Dir['exe/*', 'lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'alki', '~> 0.12.1'
end

