# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gfootgen/version'

Gem::Specification.new do |spec|
  spec.name          = "gfootgen"
  spec.version       = Gfootgen::VERSION
  spec.authors       = ["Edward Hennessy"]
  spec.email         = ["ehennes@sbcglobal.net"]
  spec.summary       = %q{Footprint Generator for PCB}
  spec.description   = %q{Footprint Generator for PCB}
  spec.homepage      = "http://www.gedasymbols.org/user/edward_hennessy"
  spec.license       = "GPL-3.0"

  spec.files         = `find . -type f -print`.split("\n")
  spec.executables   = ["gfootgen"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #spec.add_runtime_dependency 'gtk3'
  #spec.add_runtime_dependency 'json'
end
