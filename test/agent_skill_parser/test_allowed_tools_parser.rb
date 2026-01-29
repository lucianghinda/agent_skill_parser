# frozen_string_literal: true

require "test_helper"

class TestAllowedToolsParser < Minitest::Test
  def test_parses_single_tool_without_pattern
    tools = AgentSkillParser::AllowedToolsParser.new("Bash").call

    assert_equal 1, tools.length
    assert_equal "Bash", tools.first.name
    assert_nil tools.first.pattern
  end

  def test_parses_single_tool_with_pattern
    tools = AgentSkillParser::AllowedToolsParser.new("Bash(git:*)").call

    assert_equal 1, tools.length
    assert_equal "Bash", tools.first.name
    assert_equal "git:*", tools.first.pattern
  end

  def test_parses_multiple_tools
    tools = AgentSkillParser::AllowedToolsParser.new("Bash(git:*) Read Write").call

    assert_equal 3, tools.length
    assert_equal "Bash", tools[0].name
    assert_equal "git:*", tools[0].pattern
    assert_equal "Read", tools[1].name
    assert_nil tools[1].pattern
    assert_equal "Write", tools[2].name
    assert_nil tools[2].pattern
  end

  def test_returns_empty_array_for_nil
    tools = AgentSkillParser::AllowedToolsParser.new(nil).call

    assert_equal [], tools
  end

  def test_returns_empty_array_for_empty_string
    tools = AgentSkillParser::AllowedToolsParser.new("").call

    assert_equal [], tools
  end

  def test_returns_allowed_tool_data_objects
    tools = AgentSkillParser::AllowedToolsParser.new("Bash").call

    assert_instance_of AgentSkillParser::AllowedTool, tools.first
  end
end
