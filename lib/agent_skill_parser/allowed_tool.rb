# frozen_string_literal: true

module AgentSkillParser
  # Represents an allowed tool with optional regex pattern.
  #
  # @!attribute [r] name
  #   @return [String] the tool name (e.g., "bash")
  # @!attribute [r] pattern
  #   @return [String, nil] optional regex pattern for arguments
  #
  # @example Tool without pattern
  #   AllowedTool.new(name: "bash", pattern: nil)
  #
  # @example Tool with pattern
  #   AllowedTool.new(name: "search_files", pattern: "\\.(rb|js)$")
  AllowedTool = Data.define(:name, :pattern)
end
