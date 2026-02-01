# Class: AgentSkillParser::Validator
**Inherits:** Object
    

Validates frontmatter data against schema rules.

Validation rules:
*   Name: 1-64 chars, lowercase letters/numbers/hyphens only, no consecutive
    hyphens, cannot start/end with hyphen
*   Description: 1-1024 characters
*   Compatibility: optional, max 500 characters


**@example**
```ruby
fm = Frontmatter.new(name: "skill", description: "A skill", ...)
Validator.new(fm).call # => nil (no error)
```
**@example**
```ruby
fm = Frontmatter.new(name: "Bad Name!", description: "...", ...)
Validator.new(fm).call # => raises Errors::Validation
```

# Instance Methods
## call() [](#method-i-call)

**@raise** [Errors::Validation] if validation fails

**@return** [void] 

## initialize(frontmatter) [](#method-i-initialize)

**@param** [Frontmatter] parsed frontmatter data

**@return** [Validator] a new instance of Validator

