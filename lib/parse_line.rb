require "date"
require "overdue_task"
require "invalid_task_syntax"

class ParseLine
  def initialize(line:, line_number:, path:)
    @line = line
    @line_number = line_number
    @path = path.gsub("/code", "")
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    return unless line.match(/TODO/)
    result = line.match(/TODO: (\d{4}-\d{2}-\d{2}) (.*)/)

    unless result
      InvalidTaskSyntax.call(line: line, line_number: line_number, path: path)
      return
    end

    begin
      date = Date.parse(result[1])
    rescue ArgumentError
      InvalidTaskSyntax.call(line: line, line_number: line_number, path: path)
      return
    end

    return if date > Date.today

    OverdueTask.call(line: line, line_number: line_number, path: path)
  end

  protected

  attr_reader :line, :line_number, :path
end
