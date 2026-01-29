# frozen_string_literal: true

require "zeitwerk"
require "yaml"

loader = Zeitwerk::Loader.for_gem
loader.setup

# Parses skill files with YAML frontmatter and markdown body.
#
# Skill file format:
# ```yaml
# ---
# name: my-skill
# description: A helpful skill
# license: MIT
# compatibility: v1.2.3+
# metadata:
#   author: Alice
# allowed-tools: bash, search_files(\.rb$)
# ---
# # My Skill
#
# Body content here...
# ```
#
# @example Parse a skill file
#   skill = AgentSkillParser.parse("my_skill.md")
#   skill.name # => "my-skill"
#   skill.description # => "A helpful skill"
#
# @example Handle errors
#   begin
#     AgentSkillParser.parse("invalid.md")
#   rescue AgentSkillParser::Errors::Parser => e
#     puts "Parse error: #{e.message}"
#   rescue AgentSkillParser::Errors::Validation => e
#     puts "Validation error: #{e.message}"
#   end
module AgentSkillParser
  # @param file_path [String] path to skill file
  # @return [Skill] parsed skill object
  # @raise [Errors::Parser] if YAML is invalid or file cannot be read
  # @raise [Errors::Validation] if frontmatter fails validation
  # @raise [Errno::ENOENT] if file does not exist
  # @see Parser#call
  def self.parse(file_path)
    Parser.new(file_path).call
  end
end
