# frozen_string_literal: true

module AgentSkillParser
  # Main parser that orchestrates the parsing pipeline.
  #
  # Pipeline stages:
  # 1. {DocumentSplitter} - Split YAML frontmatter from body
  # 2. {FrontmatterParser} - Parse YAML into {Frontmatter}
  # 3. {Validator} - Validate frontmatter schema
  # 4. Construct {Skill} object
  #
  # @example Parse a skill file
  #   parser = Parser.new("my_skill.md")
  #   skill = parser.call
  #   skill.name # => "my-skill"
  #   skill.body # => "# My Skill..."
  class Parser
    # @param file_path [String] path to skill file
    def initialize(file_path)
      @file_path = file_path
    end

    # @return [Skill] parsed skill object
    # @raise [Errors::Parser] if YAML is invalid or file cannot be read
    # @raise [Errors::Validation] if frontmatter fails validation
    # @raise [Errno::ENOENT] if file does not exist
    def call
      text = File.read(@file_path)
      raw_yaml_document = DocumentSplitter.new(text).call

      raise Errors::Parser, "Missing required YAML frontmatter" if raw_yaml_document.yaml_string.empty?

      frontmatter = FrontmatterParser.new(raw_yaml_document.yaml_string).call
      Validator.new(frontmatter).call

      Skill.new(frontmatter: frontmatter, body: raw_yaml_document.body)
    end
  end
end
