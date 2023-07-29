# frozen_string_literal: true

require_relative "lib/dyte/version"

Gem::Specification.new do |spec|
  spec.name = "dyte"
  spec.version = Dyte::VERSION
  spec.authors = ["Nick Warwick"]
  spec.email = ["nicholaswarwick@icloud.com"]

  spec.summary = "A simple wrapper for the Dyte API."
  spec.description = "A simple wrapper for V2 of the Dyte API."
  spec.homepage = "https://github.com/nwarwick/dyte"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nwarwick/dyte"
  spec.metadata["changelog_uri"] = "https://github.com/nwarwick/dyte/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 1.10", "< 3.0"
end
