# frozen_string_literal: true

require 'psource/parser'

module Psource
  class Source
    def initialize(path, parser = Parser.new)
      @path = path
      @parser = parser
    end

    def definition_lines_begins_at(line)
      beginning_index = line - 1
      lines = File.readlines(path)
      ending_index = (beginning_index..).find do |index|
        code = lines[beginning_index..index].join
        parser.parse(code)
      end
      lines[beginning_index..ending_index]
    end

    private

    attr_reader :path, :parser
  end
end
