# Class: AgentSkillParser::AllowedToolsParser
**Inherits:** Object
    

Parses tool names with optional regex patterns for arguments.

Format: `ToolName` or `ToolName(pattern)` where pattern is optional. Multiple
tools are space or comma separated.


**@example**
```ruby
parser = AllowedToolsParser.new("bash, search_files(\\.rb$)")
parser.call
# => [
#      AllowedTool.new(name: "bash", pattern: nil),
#      AllowedTool.new(name: "search_files", pattern: "\\.rb$")
#    ]
```

# Instance Methods
## call() [](#method-i-call)

**@return** [Array<AllowedTool>] parsed tool definitions

**@see** [] 

## initialize(string) [](#method-i-initialize)

**@param** [String] comma-separated tool list

**@return** [AllowedToolsParser] a new instance of AllowedToolsParser

