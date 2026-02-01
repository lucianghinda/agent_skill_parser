# Exception: AgentSkillParser::Errors::Validation
**Inherits:** AgentSkillParser::Errors::Base
    

Raised when frontmatter validation fails.

Raised for: invalid name format, description too long/short, compatibility too
long


**@example**
```ruby
begin
  AgentSkillParser.parse("skill.md")
rescue AgentSkillParser::Errors::Validation => e
  puts "Validation error: #{e.message}"
end
```

