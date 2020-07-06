require_relative 'lib/getapp_import/version'

Gem::Specification.new do |spec|
  spec.name          = "getapp_import"
  spec.version       = GetappImport::VERSION
  spec.authors       = ["Amrinder Singh Jabbal"]
  spec.email         = ["amrinder.jabbal@gmail.com"]

  spec.summary       = %q{Data Importing Tool}
  spec.description   = %q{Gem for importing data from multiple vendors for GetApp}
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = ["getapp_import"]
  spec.require_paths = ["lib"]
end
