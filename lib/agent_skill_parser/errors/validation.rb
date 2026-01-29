# frozen_string_literal: true

module AgentSkillParser
  module Errors
    # Raised when frontmatter validation fails.
    #
    # @example Rescue pattern
    #   begin
    #     AgentSkillParser.parse("skill.md")
    #   rescue AgentSkillParser::Errors::Validation => e
    #     puts "Validation error: #{e.message}"
    #   end
    #
    # @see Validator#call
    class Validation < Base
    end
  end
end
