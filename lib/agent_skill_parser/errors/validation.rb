# frozen_string_literal: true

module AgentSkillParser
  module Errors
    # Raised when frontmatter validation fails.
    #
    # Raised for: invalid name format, description too long/short, compatibility too long
    #
    # @example Rescue pattern
    #   begin
    #     AgentSkillParser.parse("skill.md")
    #   rescue AgentSkillParser::Errors::Validation => e
    #     puts "Validation error: #{e.message}"
    #   end
    class Validation < Base
    end
  end
end
