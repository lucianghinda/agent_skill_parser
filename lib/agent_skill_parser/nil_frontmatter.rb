# frozen_string_literal: true

module AgentSkillParser
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
