require "parse_line"

RSpec.describe ParseLine, ".call" do
  context "with an empty line" do
    it "does not detect any issue" do
      allow(OverdueTask).to receive(:call)
      allow(InvalidTaskSyntax).to receive(:call)

      ParseLine.call(
        line: "",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(OverdueTask).to_not have_received(:call)
      expect(InvalidTaskSyntax).to_not have_received(:call)
    end
  end

  context "with a line not containing a TODO" do
    it "does not detect any issue" do
      allow(OverdueTask).to receive(:call)
      allow(InvalidTaskSyntax).to receive(:call)

      ParseLine.call(
        line: "foo bar",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(OverdueTask).to_not have_received(:call)
      expect(InvalidTaskSyntax).to_not have_received(:call)
    end
  end

  context "with a line containing an TODO without any description" do
    it "does not detect any issue" do
      allow(InvalidTaskSyntax).to receive(:call)

      ParseLine.call(
        line: "TODO: 2016-01-01",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(InvalidTaskSyntax).to have_received(:call)
    end
  end

  context "with a line containing a TODO with an invalid date" do
    it "does not add anything" do
      allow(InvalidTaskSyntax).to receive(:call)

      ParseLine.call(
        line: "TODO: 2019-13-13 make this better",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(InvalidTaskSyntax).to have_received(:call)
    end
  end

  context "with a line containing a not overdue TODO" do
    it "does not add anything" do
      allow(OverdueTask).to receive(:call)

      ParseLine.call(
        line: "TODO: 2019-01-03 make this better",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(OverdueTask).to_not have_received(:call)
    end
  end

  context "with a line containing an overdue TODO" do
    it "does not add anything" do
      allow(OverdueTask).to receive(:call)

      ParseLine.call(
        line: "TODO: 2012-01-03 make this better",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(OverdueTask).to have_received(:call)
    end
  end

  context "with a line containing a TODO not properly formatted" do
    it "does not add anything" do
      allow(InvalidTaskSyntax).to receive(:call)

      ParseLine.call(
        line: "TODO make this better",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(InvalidTaskSyntax).to have_received(:call)
    end
  end

  context "with a line containing a TODO with a description but no date" do
    it "does not add anything" do
      allow(InvalidTaskSyntax).to receive(:call)

      ParseLine.call(
        line: "TODO: make this better",
        line_number: 7,
        path: "foo/bar.txt"
      )

      expect(InvalidTaskSyntax).to have_received(:call)
    end
  end
end
