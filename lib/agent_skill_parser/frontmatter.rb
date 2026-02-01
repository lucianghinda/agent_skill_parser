# frozen_string_literal: true

module AgentSkillParser
  # Parsed frontmatter data from a skill file.
  #
  # @!attribute [r] name
  #   @return [String] skill identifier (lowercase, hyphens, no spaces)
  # @!attribute [r] description
  #   @return [String] human-readable description
  # @!attribute [r] license
  #   @return [String, nil] license name (optional)
  # @!attribute [r] compatibility
  #   @return [String, nil] compatibility notes (optional)
  # @!attribute [r] metadata
  #   @return [Hash{String => String}] custom key-value metadata
  # @!attribute [r] allowed_tools
  #   @return [Array<AllowedTool>] list of allowed tools
  #
  # @example
  #   Frontmatter.new(
  #     name: "my-skill",
  #     description: "A useful skill",
  #     license: "MIT",
  #     compatibility: "v1.2.3+",
  #     metadata: { "author" => "Alice" },
  #     allowed_tools: [AllowedTool.new(name: "bash", pattern: nil)]
  #   )
  Frontmatter = Data.define(:name, :description, :license, :compatibility, :metadata, :allowed_tools)

  # Nil object for empty frontmatter.
  # Returned by FrontmatterParser when YAML string is empty or missing.
  # All fields are nil or empty to safely handle missing frontmatter.
  NilFrontmatter = Frontmatter.new(
    name: "",
    description: "",
    license: nil,
    compatibility: nil,
    metadata: {},
    allowed_tools: []
  ).freeze
end
