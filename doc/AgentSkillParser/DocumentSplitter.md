# Class: AgentSkillParser::DocumentSplitter
**Inherits:** Object
    

Splits a markdown document into YAML frontmatter and body.


**@example**
```ruby
splitter = DocumentSplitter.new("---\nname: skill\n---\n# Body")
result = splitter.call
result.yaml_string # => "name: skill"
result.body # => "# Body"
```
**@example**
```ruby
splitter = DocumentSplitter.new("# Just body")
result = splitter.call
result.yaml_string # => ""
result.body # => "# Just body"
```
# Attributes
## body[RW] [](#attribute-i-body)

**@return** [String] Markdown body content

## yaml_string[RW] [](#attribute-i-yaml_string)

**@return** [String] YAML frontmatter content


# Instance Methods
## call() [](#method-i-call)

**@return** [RawYamlDocument] 

## initialize(text) [](#method-i-initialize)

**@param** [String] full document content

**@return** [DocumentSplitter] a new instance of DocumentSplitter

