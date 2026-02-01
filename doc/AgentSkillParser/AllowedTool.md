# Class: AgentSkillParser::AllowedTool
**Inherits:** Data
    

Represents an allowed tool with optional regex pattern. Pattern is used to
match tool arguments in skill files (e.g., git:* for git commands).


**@example**
```ruby
AllowedTool.new(name: "search_files", pattern: "\\.(rb|js)$")
```
**@example**
```ruby
AllowedTool.new(name: "bash", pattern: nil)
```
# Attributes
## name[RW] [](#attribute-i-name)
Returns the value of attribute name

**@return** [Object] the current value of name

## pattern[RW] [](#attribute-i-pattern)
Returns the value of attribute pattern

**@return** [Object] the current value of pattern


