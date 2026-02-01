# frozen_string_literal: true

module AgentSkillParser
  # Parses tool names with optional regex patterns for arguments.
  #
  # Format: `ToolName` or `ToolName(pattern)` where pattern is optional.
  # Multiple tools are space or comma separated.
  #
  # @example Parse tools
  #   parser = AllowedToolsParser.new("bash, search_files(\\.rb$)")
  #   parser.call
  #   # => [
  #   #      AllowedTool.new(name: "bash", pattern: nil),
  #   #      AllowedTool.new(name: "search_files", pattern: "\\.rb$")
  #   #    ]
  class AllowedToolsParser
    # Pattern matching "tool_name" or "tool_name(pattern)"
    TOOL_REGEX = /([A-Za-z_]\w*)(?:\(([^)]*)\))?/

    # @param string [String] comma-separated tool list
    def initialize(string)
      @string = string
    end

    # @return [Array<AllowedTool>] parsed tool definitions
    # @see AllowedTool
    def call
      return [] if @string.nil? || @string.empty?

      @string.scan(TOOL_REGEX).map do |name, pattern|
        AllowedTool.new(name:, pattern:)
      end
    end
  end
end
