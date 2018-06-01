
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tree_struct/version"

Gem::Specification.new do |spec|
  spec.name          = "tree_struct"
  spec.version       = TreeStruct::VERSION
  spec.authors       = ["Alexander Koltun"]
  spec.email         = ["alexander.koltun@gmail.com"]

  spec.summary       = %q{!!!merged to `form_obj` gem!!! Similar to Ruby Struct class but allows to describe nested and arrayed structures}
  spec.description   = %q{TreeStruct allows to describe a structure with nested TreeStruct and with arrays of TreeStruct.
The level of nesting is not limited.}
  spec.homepage      = "https://github.com/akoltun/tree_struct"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "typed_array", ">= 1.0.0"
  spec.add_dependency "activesupport", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "appraisal"
end
