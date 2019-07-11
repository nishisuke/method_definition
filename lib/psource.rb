# frozen_string_literal: true

require "psource/version"

module Psource
  class Error < StandardError; end
  # Your code goes here...

  autoload :Source, 'psource/source'

  module Extension
    def source
      path, line = source_location
      Source.new(path: path).definition_lines_begins_at(line)
    end
  end
end

Method.include(Psource::Extension)
UnboundMethod.include(Psource::Extension)
