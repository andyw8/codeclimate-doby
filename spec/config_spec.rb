require "config"

RSpec.describe Config do
  describe "#include_paths" do
    it "handles an empty array" do
      config = Config.new('{"include_paths":[]}')

      result = config.include_paths

      expect(result).to eq([])
    end

    it "handles an array containing paths" do
      config = Config.new('{"include_paths":["foo/bar.txt", "foo/cat.txt"]}')

      result = config.include_paths

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
