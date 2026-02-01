# Class: AgentSkillParser::Frontmatter
**Inherits:** Data
    

Parsed frontmatter data from a skill file.


**@example**
```ruby
Frontmatter.new(
  name: "my-skill",
  description: "A useful skill",
  license: "MIT",
  compatibility: "v1.2.3+",
  metadata: { "author" => "Alice" },
  allowed_tools: [AllowedTool.new(name: "bash", pattern: nil)]
)
```
# Attributes
## allowed_tools[RW] [](#attribute-i-allowed_tools)
Returns the value of attribute allowed_tools

**@return** [Object] the current value of allowed_tools

## compatibility[RW] [](#attribute-i-compatibility)
Returns the value of attribute compatibility

**@return** [Object] the current value of compatibility

## description[RW] [](#attribute-i-description)
Returns the value of attribute description

**@return** [Object] the current value of description

## license[RW] [](#attribute-i-license)
Returns the value of attribute license

**@return** [Object] the current value of license

## metadata[RW] [](#attribute-i-metadata)
Returns the value of attribute metadata

**@return** [Object] the current value of metadata

## name[RW] [](#attribute-i-name)
Returns the value of attribute name

**@return** [Object] the current value of name


