# frozen_string_literal: true

require "test_helper"

class TestDocumentSplitter < Minitest::Test
  def test_splits_valid_frontmatter_and_body
    text = <<~TEXT
      ---
      name: test
      description: A test
      ---
      ## Body
      Some content
    TEXT

    raw_yaml_document = AgentSkillParser::DocumentSplitter.new(text).call

    assert_equal "name: test\ndescription: A test", raw_yaml_document.yaml_string
    assert_equal "## Body\nSome content", raw_yaml_document.body
  end

  def test_returns_empty_yaml_and_full_body_when_no_frontmatter
    text = "## Body\nSome content"

    raw_yaml_document = AgentSkillParser::DocumentSplitter.new(text).call

    assert_equal "", raw_yaml_document.yaml_string
    assert_equal "## Body\nSome content", raw_yaml_document.body
  end

  def test_handles_whitespace_around_delimiters
    text = "  ---\nname: test\n---\n## Body"

    raw_yaml_document = AgentSkillParser::DocumentSplitter.new(text).call

    assert_equal "name: test", raw_yaml_document.yaml_string
    assert_equal "## Body", raw_yaml_document.body
  end
end
