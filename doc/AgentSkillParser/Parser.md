# Class: AgentSkillParser::Parser
**Inherits:** Object
    

Orchestrates the parsing pipeline for skill files.

Pipeline stages: DocumentSplitter → FrontmatterParser → Validator → Skill
construction


**@example**
```ruby
parser = Parser.new("my_skill.md")
skill = parser.call
skill.name # => "my-skill"
skill.body # => "# My Skill..."
```

# Instance Methods
## call() [](#method-i-call)

**@raise** [Errors::Parser] if YAML is invalid or file cannot be read

**@raise** [Errors::Validation] if frontmatter fails validation

**@raise** [Errno::ENOENT] if file does not exist

**@return** [Skill] parsed skill object

## initialize(file_path) [](#method-i-initialize)

**@param** [String] path to skill file

**@return** [Parser] a new instance of Parser

