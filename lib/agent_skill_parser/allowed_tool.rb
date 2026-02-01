# frozen_string_literal: true

module AgentSkillParser
  # Represents an allowed tool with optional regex pattern.
  # Pattern is used to match tool arguments in skill files (e.g., git:* for git commands).
  #
  # @!attribute [r] name
  #   @return [String] tool name (e.g., "bash")
  # @!attribute [r] pattern
  #   @return [String, nil] optional regex pattern for arguments
  #
  # @example Tool with pattern
  #   AllowedTool.new(name: "search_files", pattern: "\\.(rb|js)$")
  # @example Tool without pattern
  #   AllowedTool.new(name: "bash", pattern: nil)
  AllowedTool = Data.define(:name, :pattern)
end
