# frozen_string_literal: true

require "psource/version"

class Hoge
  def rm
  end
end

module Psource
  class Error < StandardError; end
  # Your code goes here...

  autoload :Source, 'psource/source'

  module Extension
    def source
      path, line = source_location
      Source.new(path).snip_definition_from(line)
    end
  end
end

[Method, UnboundMethod].each do |klass|
  klass.include(Psource::Extension)
end
