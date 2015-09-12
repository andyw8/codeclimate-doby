require "parse_line"

class ParseFileContents
  OFFSET = 1

  def self.call(content:, path:)
    content.each_line.with_index(OFFSET) do |line, line_number|
      next unless line.match(/TODO/)
      ParseLine.new(
        line: line.strip,
        line_number: line_number,
        path: path
      ).call
    end
  end
end
