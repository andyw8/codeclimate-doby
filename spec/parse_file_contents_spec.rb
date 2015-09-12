require "parse_file_contents"

RSpec.describe ParseFileContents, ".call" do
  context "with empty content" do
    it "doesn't parse any lines" do
      allow(ParseLine).to receive(:new)

      ParseFileContents.call(content: "", path: "/code/foo.txt")

      expect(ParseLine).to_not have_received(:new)
    end
  end

  context "with a line which is not a TODO" do
    it "doesn't parse the line" do
      allow(ParseLine).to receive(:new)

      ParseFileContents.call(content: "foo bar", path: "/code/foo.txt")

      expect(ParseLine).to_not have_received(:new)
    end
  end

  context "with a line which is a TODO" do
    it "parses the line" do
      parse_line = double(:parse_line)
      allow(parse_line).to receive(:call)
      allow(ParseLine).to receive(:new).and_return(parse_line)
      content = "first line\nTODO something\nlast line"

      ParseFileContents.call(content: content, path: "/code/foo.txt")

      expect(ParseLine).to have_received(:new).with(
        line: "TODO something",
        line_number: 2,
        path: "/code/foo.txt"
      )
    end
  end
end
