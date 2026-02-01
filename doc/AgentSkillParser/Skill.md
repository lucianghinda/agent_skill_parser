# Class: AgentSkillParser::Skill
**Inherits:** Data
    

A parsed skill with frontmatter and body.


**@example**
```ruby
Skill.new(
  frontmatter: Frontmatter.new(name: "skill", description: "...", ...),
  body: "# My Skill\n\n..."
)
```
# Attributes
## body[RW] [](#attribute-i-body)
Returns the value of attribute body

**@return** [Object] the current value of body

## frontmatter[RW] [](#attribute-i-frontmatter)
Returns the value of attribute frontmatter

**@return** [Object] the current value of frontmatter


# Instance Methods
## description() [](#method-i-description)

**@return** [String] skill description (delegates to frontmatter)

## name() [](#method-i-name)

**@return** [String] skill name (delegates to frontmatter)

