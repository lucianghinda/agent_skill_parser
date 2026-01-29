# frozen_string_literal: true

require "test_helper"

class TestFrontmatterParser < Minitest::Test
  def test_parses_full_frontmatter
    yaml = <<~YAML
      name: test-skill
      description: A test skill
      license: MIT
      compatibility: OpenAI
      metadata:
        author: Test Author
        version: 1.0
      allowed-tools: Bash(git:*) Read
    YAML

    frontmatter = AgentSkillParser::FrontmatterParser.new(yaml).call

    assert_equal "test-skill", frontmatter.name
    assert_equal "A test skill", frontmatter.description
    assert_equal "MIT", frontmatter.license
    assert_equal "OpenAI", frontmatter.compatibility
    assert_equal({ "author" => "Test Author", "version" => "1.0" }, frontmatter.metadata)
    assert_equal 2, frontmatter.allowed_tools.length
    assert_equal "Bash", frontmatter.allowed_tools[0].name
    assert_equal "git:*", frontmatter.allowed_tools[0].pattern
  end

  def test_parses_minimal_frontmatter
    yaml = "name: test\ndescription: A description"

    frontmatter = AgentSkillParser::FrontmatterParser.new(yaml).call

    assert_equal "test", frontmatter.name
    assert_equal "A description", frontmatter.description
    assert_nil frontmatter.license
    assert_nil frontmatter.compatibility
    assert_equal({}, frontmatter.metadata)
    assert_equal [], frontmatter.allowed_tools
  end

  def test_returns_default_frontmatter_for_empty_yaml
    frontmatter = AgentSkillParser::FrontmatterParser.new("").call

    assert_equal "", frontmatter.name
    assert_equal "", frontmatter.description
    assert_nil frontmatter.license
    assert_nil frontmatter.compatibility
    assert_equal({}, frontmatter.metadata)
    assert_equal [], frontmatter.allowed_tools
  end

  def test_coerces_metadata_values_to_strings
    yaml = <<~YAML
      name: test
      description: test
      metadata:
        number: 123
        boolean: true
        string: text
    YAML

    frontmatter = AgentSkillParser::FrontmatterParser.new(yaml).call

    assert_equal "123", frontmatter.metadata["number"]
    assert_equal "true", frontmatter.metadata["boolean"]
    assert_equal "text", frontmatter.metadata["string"]
  end

  def test_raises_parse_error_for_invalid_yaml
    yaml = "name: test\ninvalid: [unclosed"

    error = assert_raises AgentSkillParser::Errors::Parser do
      AgentSkillParser::FrontmatterParser.new(yaml).call
    end

    assert_match(/Invalid YAML/, error.message)
  end

  def test_returns_frontmatter_data_object
    yaml = "name: test\ndescription: test"

    frontmatter = AgentSkillParser::FrontmatterParser.new(yaml).call

    assert_instance_of AgentSkillParser::Frontmatter, frontmatter
  end
end
