# frozen_string_literal: true

require_relative "lib/rails_fake_api/version"

Gem::Specification.new do |spec|
  spec.name = "rails_fake_api"
  spec.version = RailsFakeApi::VERSION
  spec.authors = ["Fernando Kosh"]
  spec.email = ["fernando.kosh@gmail.com"]

  spec.summary = "RailsFakeApi is a Ruby on Rails engine that provides a simple, in-memory (file-based) fake API server, similar to json-server. "
  spec.description = "RailsFakeApi is a Ruby on Rails engine that provides a simple, in-memory (file-based) fake API server, similar to json-server. It runs alongside your main Rails application, allowing you to easily mock API endpoints for frontend development, testing, or quick prototyping without setting up a full database."
  spec.homepage = "https://github.com/koshtech/rails_fake_api"
  spec.license = "GNU Affero General Public License v3.0"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/koshtech/rails_fake_api"
  spec.metadata["changelog_uri"] = "https://github.com/koshtech/rails_fake_api"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency "rails", ">= 8.0.0" # Defina a versão mínima do Rails que sua gem suporta

  # Dependências de desenvolvimento (opcional, mas bom ter)
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha", "~> 2.0"
  spec.add_development_dependency "simplecov", "~> 0.22"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
