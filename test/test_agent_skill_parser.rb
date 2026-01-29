# frozen_string_literal: true

require "test_helper"

class TestAgentSkillParser < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AgentSkillParser::VERSION
  end

  def test_parse_convenience_method
    skill = AgentSkillParser.parse("test/fixtures/valid_full.md")

    assert_instance_of AgentSkillParser::Skill, skill
    assert_equal "pdf-processing", skill.name
  end
end
