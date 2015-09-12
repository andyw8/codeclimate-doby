require 'json'
# require 'bundler'
# Bundler.require
# require "codeclimate_engine"

class InvalidTaskSyntax
  def initialize(line:, path:, line_number:)
    @line = line
    @path = path
    @line_number = line_number
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    location = CCEngine::Location::LineRange.new(
      path:       path,
      line_range: line_number..line_number
    )

    issue = CCEngine::Issue.new(
      check_name:  "ToDo",
      description: "Invalid task syntax",
      categories:  [CCEngine::Category.complexity],
      location:    location
    )

    puts JSON.pretty_generate(issue.to_hash)
    puts "\0"
  end

  protected

  attr_reader :line, :path, :line_number
end