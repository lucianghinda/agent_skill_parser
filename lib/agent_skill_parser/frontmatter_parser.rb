# frozen_string_literal: true

require "yaml"

module AgentSkillParser
  # Parses YAML frontmatter into a {Frontmatter} object.
  #
  # @example Parse frontmatter
  #   parser = FrontmatterParser.new("name: my-skill\ndescription: A skill")
  #   parser.call # => Frontmatter.new(name: "my-skill", description: "A skill", ...)
  class FrontmatterParser
    # @param yaml_string [String] YAML content (may be empty)
    def initialize(yaml_string)
      @yaml_string = yaml_string
    end

    # @return [Frontmatter] parsed frontmatter data
    # @raise [Errors::Parser] if YAML is invalid
    def call
      return AgentSkillParser::NilFrontmatter if @yaml_string.empty?

      data = parse_yaml
      build_frontmatter(data)
    rescue Psych::SyntaxError => e
      raise Errors::Parser, "Invalid YAML: #{e.message}"
    end

    private

    # @return [Hash] parsed YAML data
    def parse_yaml
      YAML.safe_load(@yaml_string) || {}
    end

    # @param data [Hash] raw YAML data
    # @return [Frontmatter] constructed frontmatter
    def build_frontmatter(data)
      allowed_tools_data = data.delete("allowed-tools")
      metadata_data = data.delete("metadata") || {}

      Frontmatter.new(
        name: data["name"] || "",
        description: data["description"] || "",
        license: data["license"],
        compatibility: data["compatibility"],
        metadata: coerce_metadata(metadata_data),
        allowed_tools: parse_allowed_tools(allowed_tools_data)
      )
    end

    # @param data [Object] metadata value
    # @return [Hash{String => String}] stringified metadata
    def coerce_metadata(data)
      return {} unless data.is_a?(Hash)

      data.transform_values(&:to_s).freeze
    end

    # @param data [String, Array, nil] allowed-tools value
    # @return [Array<AllowedTool>] parsed tool list
    def parse_allowed_tools(data)
      return [] if data.nil? || data.empty?

      case data
      when String
        AllowedToolsParser.new(data).call
      when Array
        data.flat_map { |item| AllowedToolsParser.new(item.to_s).call }.freeze
      else
        []
      end
    end
  end
end
