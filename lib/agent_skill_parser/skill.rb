# frozen_string_literal: true

module AgentSkillParser
  # A parsed skill with frontmatter and body.
  #
  # @!attribute [r] frontmatter
  #   @return [Frontmatter] parsed metadata
  # @!attribute [r] body
  #   @return [String] markdown content after frontmatter
  #
  # @example
  #   Skill.new(
  #     frontmatter: Frontmatter.new(name: "skill", description: "...", ...),
  #     body: "# My Skill\n\n..."
  #   )
  Skill = Data.define(:frontmatter, :body) do
    # @return [String] skill name (delegates to frontmatter)
    # @see Frontmatter#name
    def name
      frontmatter.name
    end

    # @return [String] skill description (delegates to frontmatter)
    # @see Frontmatter#description
    def description
      frontmatter.description
    end
  end
end
