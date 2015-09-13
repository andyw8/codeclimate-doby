require "find"

# Return a list of files in the given path (recusively).
# Skips directores and files beginning with a dot.
class Scanner
  PATH_PREFIX = "/code/"

  def initialize(path, config)
    @path, @config = path, config
  end

  def self.call(path, config)
    new(path, config).call
  end

  def call
    Find.find(path).select { |f| included?(f) }
  end

  protected

  attr_reader :path, :config

  private

  def included?(path)
    return false if File.directory?(path)

    config.include_paths.any? do |include_path|
      path.gsub(PATH_PREFIX, '').start_with?(include_path)
    end
  end
end
