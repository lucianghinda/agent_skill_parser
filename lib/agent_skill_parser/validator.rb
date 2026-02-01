# frozen_string_literal: true

module AgentSkillParser
  # Validates frontmatter data against schema rules.
  #
  # Validation rules:
  # - Name: 1-64 chars, lowercase letters/numbers/hyphens only, no consecutive hyphens,
  #   cannot start/end with hyphen
  # - Description: 1-1024 characters
  # - Compatibility: optional, max 500 characters
  #
  # @example Successful validation
  #   fm = Frontmatter.new(name: "skill", description: "A skill", ...)
  #   Validator.new(fm).call # => nil (no error)
  #
  # @example Failed validation
  #   fm = Frontmatter.new(name: "Bad Name!", description: "...", ...)
  #   Validator.new(fm).call # => raises Errors::Validation
  class Validator
    # Maximum name length
    NAME_MAX_LENGTH = 64
    # Minimum name length
    NAME_MIN_LENGTH = 1
    # Allowed name pattern
    NAME_PATTERN = /\A[a-z0-9-]+\z/
    # Maximum description length
    DESCRIPTION_MAX_LENGTH = 1024
    # Minimum description length
    DESCRIPTION_MIN_LENGTH = 1
    # Maximum compatibility length
    COMPATIBILITY_MAX_LENGTH = 500

    # @param frontmatter [Frontmatter] parsed frontmatter data
    def initialize(frontmatter)
      @frontmatter = frontmatter
    end

    # @return [void]
    # @raise [Errors::Validation] if validation fails
    def call
      validate_name
      validate_description
      validate_compatibility
    end

    private

    # @return [void]
    # @raise [Errors::Validation] if name is invalid
    # :nodoc:
    def validate_name
      name = @frontmatter.name

      raise Errors::Validation, "Name must be at least #{NAME_MIN_LENGTH} character(s)" if name.length < NAME_MIN_LENGTH

      raise Errors::Validation, "Name must be at most #{NAME_MAX_LENGTH} characters" if name.length > NAME_MAX_LENGTH

      unless name.match?(NAME_PATTERN)
        raise Errors::Validation, "Name must contain only lowercase letters, numbers, and hyphens"
      end

      raise Errors::Validation, "Name cannot contain consecutive hyphens" if name.include?("--")

      return unless name.start_with?("-") || name.end_with?("-")

      raise Errors::Validation, "Name cannot start or end with a hyphen"
    end

    # @return [void]
    # @raise [Errors::Validation] if description is invalid
    # :nodoc:
    def validate_description
      description = @frontmatter.description

      if description.length < DESCRIPTION_MIN_LENGTH
        raise Errors::Validation, "Description must be at least #{DESCRIPTION_MIN_LENGTH} character(s)"
      end

      return unless description.length > DESCRIPTION_MAX_LENGTH

      raise Errors::Validation, "Description must be at most #{DESCRIPTION_MAX_LENGTH} characters"
    end

    # @return [void]
    # @raise [Errors::Validation] if compatibility is too long
    # :nodoc:
    def validate_compatibility
      return if @frontmatter.compatibility.nil?

      return unless @frontmatter.compatibility.length > COMPATIBILITY_MAX_LENGTH

      raise Errors::Validation, "Compatibility must be at most #{COMPATIBILITY_MAX_LENGTH} characters"
    end
  end
end
