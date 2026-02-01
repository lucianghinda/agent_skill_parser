# AgentSkillParser

A Ruby gem for parsing skill files that use YAML frontmatter and markdown body content. Designed for agent/AI systems where skills are defined as structured markdown documents with metadata.

Warning: 
- This gem does not protect against Prompt Injection so if you read with this a skill file and pipe it through an LLM it will send there the exact skill file without any filtering. 
- It only parses the structure of the skill according with the specification from https://agentskills.io/specification

## Installation

Add this line to your application's Gemfile:

```ruby
gem "agent_skill_parser"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install agent_skill_parser
```

## Skill File Format

A skill file is a markdown document with YAML frontmatter delimited by `---`:

```markdown
---
name: pdf-processing
description: Extract text from PDF documents using various parsing strategies
license: Apache-2.0
compatibility: OpenAI Anthropic
metadata:
  author: Acme Inc
  version: 1.0.0
  category: document-processing
allowed-tools: Bash(git:*) Read
---

## Instructions

This skill helps extract text from PDFs.

### Step 1: Download the PDF
Use the Bash tool to download PDF files from URLs.
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Skill identifier. Lowercase letters, numbers, and hyphens only (1-64 chars). Cannot start/end with a hyphen or contain consecutive hyphens. |
| `description` | Yes | Human-readable description (1-1024 chars). |
| `license` | No | License name (e.g., `MIT`, `Apache-2.0`). |
| `compatibility` | No | Compatibility notes (max 500 chars). |
| `metadata` | No | Custom key-value pairs. Values are coerced to strings. |
| `allowed-tools` | No | Space or comma-separated tool names, optionally with patterns: `Bash(git:*) Read Write`. |

### Allowed Tools Format

Tools can be listed with optional regex patterns in parentheses:

```yaml
allowed-tools: Bash(git:*) Read Write
```

This produces `AllowedTool` objects where `Bash` has a pattern of `git:*`, and `Read`/`Write` have no pattern.

## Usage

### Parsing a Skill File

```ruby
skill = AgentSkillParser.parse("path/to/skill.md")

skill.name          # => "pdf-processing"
skill.description   # => "Extract text from PDF documents..."
skill.body          # => "## Instructions\n\nThis skill helps..."
```

### Accessing Frontmatter

```ruby
fm = skill.frontmatter

fm.name             # => "pdf-processing"
fm.description      # => "Extract text from PDF documents..."
fm.license          # => "Apache-2.0"
fm.compatibility    # => "OpenAI Anthropic"
fm.metadata         # => {"author" => "Acme Inc", "version" => "1.0.0", "category" => "document-processing"}
fm.allowed_tools    # => [#<AllowedTool name="Bash" pattern="git:*">, ...]
```

### Accessing Allowed Tools

```ruby
tool = skill.frontmatter.allowed_tools.first

tool.name    # => "Bash"
tool.pattern # => "git:*"
```

### Error Handling

```ruby
begin
  AgentSkillParser.parse("skill.md")
rescue AgentSkillParser::Errors::Parser => e
  puts "Parse error: #{e.message}"
rescue AgentSkillParser::Errors::Validation => e
  puts "Validation error: #{e.message}"
rescue Errno::ENOENT => e
  puts "File not found: #{e.message}"
end
```

- `Errors::Parser` -- raised when YAML is malformed or the file cannot be read.
- `Errors::Validation` -- raised when frontmatter values violate schema rules (e.g., invalid name format, description too long).

### Minimal Skill File

A skill file only requires `name` and `description`:

```markdown
---
name: simple-skill
description: A simple skill for testing
---

## Instructions

This is a simple skill.
```

### Files Without Frontmatter

Files without YAML frontmatter are parsed with an empty frontmatter and the entire content as the body.

## Architecture

The parsing pipeline consists of four stages:

1. **DocumentSplitter** -- Separates YAML frontmatter from the markdown body.
2. **FrontmatterParser** -- Parses the YAML string into a `Frontmatter` object.
3. **Validator** -- Validates frontmatter against schema rules.
4. **Skill construction** -- Combines the validated frontmatter and body into a `Skill` object.

All data structures (`Skill`, `Frontmatter`, `AllowedTool`) are immutable, built using Ruby's `Data.define`.

## Requirements

- Ruby >= 3.2.0

## Development

Note: 
- The code of this gem was generated with Claude Code + GLM but I review it manually and even if in some cases the code design could be better I feel like it is good enough for a first release. 

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

```bash
bundle exec rake test     # Run tests
bundle exec rake rubocop  # Run linter
bundle exec rake yard     # Generate documentation
bundle exec rake          # Run tests + linter
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
