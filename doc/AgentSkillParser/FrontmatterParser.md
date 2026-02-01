# Class: AgentSkillParser::FrontmatterParser
**Inherits:** Object
    

Parses YAML frontmatter into a {Frontmatter} object.


**@example**
```ruby
parser = FrontmatterParser.new("name: my-skill\ndescription: A skill")
parser.call # => Frontmatter.new(name: "my-skill", description: "A skill", ...)
```

# Instance Methods
## call() [](#method-i-call)

**@raise** [Errors::Parser] if YAML is invalid

**@return** [Frontmatter] parsed frontmatter data

## initialize(yaml_string) [](#method-i-initialize)

**@param** [String] YAML content (may be empty)

**@return** [FrontmatterParser] a new instance of FrontmatterParser

