# frozen_string_literal: true

require_relative "lib/agent_skill_parser/version"

Gem::Specification.new do |spec|
  spec.name = "agent_skill_parser"
  spec.version = AgentSkillParser::VERSION
  spec.authors = ["Lucian Ghinda"]
  spec.email = ["lucian@shortruby.com"]

  spec.summary = "Parse agent skill files with YAML frontmatter and markdown body for agent/AI systems"
  spec.description = "A Ruby gem for parsing skill files that use YAML frontmatter and markdown body content. " \
                     "Provides document splitting, YAML parsing, schema validation, and returns immutable " \
                     "Skill objects. Designed for agent/AI systems where skills are defined as structured " \
                     "markdown documents with metadata."
  spec.homepage = "https://github.com/lucianghinda/agent_skill_parser"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/lucianghinda/agent_skill_parser/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk", "~> 2.6"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
