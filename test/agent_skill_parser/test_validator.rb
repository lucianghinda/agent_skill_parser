# frozen_string_literal: true

require "test_helper"

class TestValidator < Minitest::Test
  def test_validates_valid_frontmatter
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "valid-skill",
      description: "A valid description",
      license: "MIT",
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    AgentSkillParser::Validator.new(frontmatter).call

    pass
  end

  def test_raises_error_for_empty_name
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "",
      description: "A description",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Name must be at least/, error.message)
  end

  def test_raises_error_for_name_too_long
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "a" * 65,
      description: "A description",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Name must be at most/, error.message)
  end

  def test_raises_error_for_invalid_name_characters
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "Invalid_Name",
      description: "A description",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Name must contain only/, error.message)
  end

  def test_raises_error_for_consecutive_hyphens
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "invalid--name",
      description: "A description",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Name cannot contain consecutive hyphens/, error.message)
  end

  def test_raises_error_for_leading_hyphen
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "-invalid",
      description: "A description",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Name cannot start or end with a hyphen/, error.message)
  end

  def test_raises_error_for_trailing_hyphen
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "invalid-",
      description: "A description",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Name cannot start or end with a hyphen/, error.message)
  end

  def test_raises_error_for_empty_description
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "valid",
      description: "",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Description must be at least/, error.message)
  end

  def test_raises_error_for_description_too_long
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "valid",
      description: "a" * 1025,
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Description must be at most/, error.message)
  end

  def test_raises_error_for_compatibility_too_long
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "valid",
      description: "A description",
      license: nil,
      compatibility: "a" * 501,
      metadata: {},
      allowed_tools: []
    )

    error = assert_raises AgentSkillParser::Errors::Validation do
      AgentSkillParser::Validator.new(frontmatter).call
    end

    assert_match(/Compatibility must be at most/, error.message)
  end

  def test_allows_nil_compatibility
    frontmatter = AgentSkillParser::Frontmatter.new(
      name: "valid",
      description: "A description",
      license: nil,
      compatibility: nil,
      metadata: {},
      allowed_tools: []
    )

    AgentSkillParser::Validator.new(frontmatter).call

    pass
  end
end
