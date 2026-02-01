# frozen_string_literal: true

module AgentSkillParser
  # Splits a markdown document into YAML frontmatter and body.
  #
  # @example With frontmatter
  #   splitter = DocumentSplitter.new("---\nname: skill\n---\n# Body")
  #   result = splitter.call
  #   result.yaml_string # => "name: skill"
  #   result.body # => "# Body"
  #
  # @example Without frontmatter
  #   splitter = DocumentSplitter.new("# Just body")
  #   result = splitter.call
  #   result.yaml_string # => ""
  #   result.body # => "# Just body"
  class DocumentSplitter
    # Represents a raw YAML document with separated YAML frontmatter and body.
    # Used as an intermediate structure during parsing.
    #
    # @!attribute [r] yaml_string
    #   @return [String] YAML frontmatter content
    # @!attribute [r] body
    #   @return [String] Markdown body content
    RawYamlDocument = Data.define(:yaml_string, :body)

    # @param text [String] full document content
    def initialize(text)
      @text = text
    end

    # @return [RawYamlDocument]
    def call
      parts = @text.lstrip.split(/^---$/, 3)

      if parts.length == 3 && parts[0].empty?
        RawYamlDocument.new(yaml_string: parts[1].strip, body: parts[2].strip)
      else
        RawYamlDocument.new(yaml_string: "", body: @text.strip)
      end
    end
  end
end
