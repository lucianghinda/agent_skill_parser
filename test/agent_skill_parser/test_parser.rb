# frozen_string_literal: true

require "test_helper"

class TestParser < Minitest::Test
  def test_parses_valid_full_skill_file
    skill = AgentSkillParser.parse("test/fixtures/valid_full.md")

    assert_instance_of AgentSkillParser::Skill, skill
    assert_equal "pdf-processing", skill.name
    assert_equal "Extract text from PDF documents using various parsing strategies", skill.description
    assert_equal "Apache-2.0", skill.frontmatter.license
    assert_equal "OpenAI Anthropic", skill.frontmatter.compatibility
    assert_equal({ "author" => "Acme Inc", "version" => "1.0.0", "category" => "document-processing" },
                 skill.frontmatter.metadata)
    assert_equal 2, skill.frontmatter.allowed_tools.length
    assert_equal "Bash", skill.frontmatter.allowed_tools[0].name
    assert_equal "git:*", skill.frontmatter.allowed_tools[0].pattern
    assert_equal "Read", skill.frontmatter.allowed_tools[1].name
    assert skill.body.include?("## Instructions")
  end

  def test_parses_valid_minimal_skill_file
    skill = AgentSkillParser.parse("test/fixtures/valid_minimal.md")

    assert_instance_of AgentSkillParser::Skill, skill
    assert_equal "simple-skill", skill.name
    assert_equal "A simple skill for testing", skill.description
    assert_nil skill.frontmatter.license
    assert_nil skill.frontmatter.compatibility
    assert_equal({}, skill.frontmatter.metadata)
    assert_equal([], skill.frontmatter.allowed_tools)
    assert skill.body.include?("## Instructions")
  end

  def test_raises_parser_error_for_file_without_frontmatter
    error = assert_raises AgentSkillParser::Errors::Parser do
      AgentSkillParser.parse("test/fixtures/no_frontmatter.md")
    end

    assert_match(/frontmatter/, error.message)
  end

  def test_raises_validation_error_for_invalid_name
    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser.parse("test/fixtures/invalid_name.md")
    end

    assert_match(/Name must contain only/, error.message)
  end

  def test_skill_delegates_name_and_description
    skill = AgentSkillParser.parse("test/fixtures/valid_full.md")

    assert_equal skill.frontmatter.name, skill.name
    assert_equal skill.frontmatter.description, skill.description
  end
end
