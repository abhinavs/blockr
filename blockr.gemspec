require_relative 'lib/blockr/version'

Gem::Specification.new do |spec|
  spec.name          = "blockr"
  spec.license       = "MIT"
  spec.version       = Blockr::VERSION
  spec.authors       = ["Abhinav Saxena"]
  spec.email         = ["abhinav061@gmail.com"]

  spec.summary       = %q{blockr is a commandline line tool to help you easily block websites, and unblock them when you need them}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "http://www.abhinav.co/blockr.html"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/abhinavs/blockr"
  spec.metadata["changelog_uri"] = "https://github.com/abhinavs/blockr"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end


  spec.add_runtime_dependency "thor", "~> 1.0.1"
  spec.add_runtime_dependency "tty-file", "~> 0.9.0"
  spec.add_runtime_dependency "tty-command", "~> 0.9.0"


  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
