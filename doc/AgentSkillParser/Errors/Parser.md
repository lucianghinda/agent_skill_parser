# Exception: AgentSkillParser::Errors::Parser
**Inherits:** AgentSkillParser::Errors::Base
    

Raised when parsing fails.

Raised for: invalid YAML, missing frontmatter, file not found


**@example**
```ruby
begin
  AgentSkillParser.parse("invalid.md")
rescue AgentSkillParser::Errors::Parser => e
  puts "Parsing error: #{e.message}"
end
```

