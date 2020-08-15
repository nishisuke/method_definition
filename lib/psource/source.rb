# frozen_string_literal: true

require 'psource/parser'

module Psource
  class Source
    def initialize(path, parser = Parser.new)
      @path = path
      @parser = parser
    end

    def snip_definition_from(line)
      beginning_index = line - 1
      ending_index = (beginning_index..).find do |index|
        code = lines[beginning_index..index].join
        parser.parse(code)
      end
      snippet = snip(beginning_index..ending_index)
      Definition.new(snippet)
    end

    private

    attr_reader :path, :parser

    def lines
      @lines ||= File.readlines(path)
    end

    def snip(range)
      lines[range].join
    end

    class Definition
      def initialize(snippet)
        @snippet = snippet
      end
    end
  end
end
