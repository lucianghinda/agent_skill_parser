# Module: AgentSkillParser
    

Parses skill files with YAML frontmatter and markdown body.

Skill file format: ```markdown
---
name: my-skill description: A helpful skill license: MIT compatibility:
v1.2.3+ metadata:
    author: Alice

allowed-tools: bash, search_files(.rb$)
---
# My Skill

Body content here... ```


**@example**
```ruby
skill = AgentSkillParser.parse("my_skill.md")
skill.name # => "my-skill"
skill.description # => "A helpful skill"
```
**@example**
```ruby
begin
  AgentSkillParser.parse("invalid.md")
rescue AgentSkillParser::Errors::Parser => e
  puts "Parse error: #{e.message}"
rescue AgentSkillParser::Errors::Validation => e
  puts "Validation error: #{e.message}"
end
```
# Class Methods
## parse(file_path ) [](#method-c-parse)
**@param** [String] path to skill file

**@raise** [Errors::Parser] if YAML is invalid or file cannot be read

**@raise** [Errors::Validation] if frontmatter fails validation

**@raise** [Errno::ENOENT] if file does not exist

**@return** [Skill] parsed skill object

# Attributes
## allowed_tools[RW] [](#attribute-i-allowed_tools)

**@return** [Array<AllowedTool>] list of allowed tools

## body[RW] [](#attribute-i-body)

**@return** [String] markdown content after frontmatter

## compatibility[RW] [](#attribute-i-compatibility)

**@return** [String, nil] compatibility notes (optional)

## description[RW] [](#attribute-i-description)

**@return** [String] human-readable description

## frontmatter[RW] [](#attribute-i-frontmatter)

**@return** [Frontmatter] parsed metadata

## license[RW] [](#attribute-i-license)

**@return** [String, nil] license name (optional)

## metadata[RW] [](#attribute-i-metadata)

**@return** [Hash{String => String}] custom key-value metadata

## name[RW] [](#attribute-i-name)

**@return** [String] tool name (e.g., "bash")

## pattern[RW] [](#attribute-i-pattern)

**@return** [String, nil] optional regex pattern for arguments

# Documentation

- [doc/AgentSkillParser/AllowedTool.md](doc/AgentSkillParser/AllowedTool.md)
- [doc/AgentSkillParser/AllowedToolsParser.md](doc/AgentSkillParser/AllowedToolsParser.md)
- [doc/AgentSkillParser/DocumentSplitter.md](doc/AgentSkillParser/DocumentSplitter.md)
- [doc/AgentSkillParser/DocumentSplitter/RawYamlDocument.md](doc/AgentSkillParser/DocumentSplitter/RawYamlDocument.md)
- [doc/AgentSkillParser/Errors.md](doc/AgentSkillParser/Errors.md)
- [doc/AgentSkillParser/Errors/Base.md](doc/AgentSkillParser/Errors/Base.md)
- [doc/AgentSkillParser/Errors/Parser.md](doc/AgentSkillParser/Errors/Parser.md)
- [doc/AgentSkillParser/Errors/Validation.md](doc/AgentSkillParser/Errors/Validation.md)
- [doc/AgentSkillParser/Frontmatter.md](doc/AgentSkillParser/Frontmatter.md)
- [doc/AgentSkillParser/FrontmatterParser.md](doc/AgentSkillParser/FrontmatterParser.md)
- [doc/AgentSkillParser/Parser.md](doc/AgentSkillParser/Parser.md)
- [doc/AgentSkillParser/Skill.md](doc/AgentSkillParser/Skill.md)
- [doc/AgentSkillParser/Validator.md](doc/AgentSkillParser/Validator.md)
