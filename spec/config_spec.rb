require "config"

RSpec.describe Config do
  describe "#exclude_paths" do
    it "handles an empty array" do
      config = Config.new('{"exclude_paths":[]}')

      result = config.exclude_paths

      expect(result).to eq([])
    end

    it "handles an array containing paths" do
      config = Config.new('{"exclude_paths":["foo/bar.txt", "foo/cat.txt"]}')

      result = config.exclude_paths

      expect(result).to eq(["foo/bar.txt", "foo/cat.txt"])
    end
  end

  describe "#enabled?" do
    it "returns true if the engine is enabled" do
      config = Config.new('{"enabled":true}')

      result = config.enabled?

      expect(result).to be(true)
    end

    it "returns false if the engine is not enabled" do
      config = Config.new('{"enabled":false}')

      result = config.enabled?

      expect(result).to be(false)
    end
  end
end
