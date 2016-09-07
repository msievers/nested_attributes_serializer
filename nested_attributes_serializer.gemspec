# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nested_attributes_serializer/version"

Gem::Specification.new do |spec|
  spec.name          = "nested_attributes_serializer"
  spec.version       = NestedAttributesSerializer::VERSION
  spec.authors       = ["Michael Sievers"]

  spec.summary       = %q{ActiveModel serializer which returns hashes according to Rails nested attributes naming convention.}
  spec.homepage      = "https://github.com/msievers/nested_attributes_serializer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
