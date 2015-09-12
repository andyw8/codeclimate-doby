require "find"

# Return a list of files in the given path (recusively).
# Skips directores and files beginning with a dot.
class Scanner
  def initialize(path, config)
    @path, @config = path, config
  end

  def self.call(path, config)
    new(path, config).call
  end

  def call
    Find.find(path).map do |f|
      next unless valid_for_inclusion?(f)
      f
    end.compact
  end

  private

  def valid_for_inclusion?(f)
    return false if File.directory?(f)
    return false if f.include?("/.")
    return false if excluded?(f)
    true
  end

  def excluded?(f)
    config.exclude_paths.each do |exclude_path|
      STDERR.puts "Checking if #{f.gsub('/code/', '')} == #{exclude_path}"
      return true if f.gsub('/code/', '') == exclude_path
    end
    false
  end

  attr_reader :path, :config
end
