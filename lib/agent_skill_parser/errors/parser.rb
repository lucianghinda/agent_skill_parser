# frozen_string_literal: true

module AgentSkillParser
  module Errors
    # Raised when parsing fails.
    #
    # Raised for: invalid YAML, missing frontmatter, file not found
    #
    # @example Rescue pattern
    #   begin
    #     AgentSkillParser.parse("invalid.md")
    #   rescue AgentSkillParser::Errors::Parser => e
    #     puts "Parsing error: #{e.message}"
    #   end
    class Parser < Base
    end
  end
end
