require "do_by"

RSpec.describe DoBy do
  it "raises NoDueDateTask if a date is not provided" do
    expect do
      DoBy::Note.new("note description")
    end.to raise_error DoBy::NoDueDateTask, "missing due date"
  end

  # TODO utc?
  it "raises LateTask if the date has passed" do
    expect do
      DoBy::Note.new("note description", "31 Dec 1999")
    end.to raise_error DoBy::LateTask, "note description is overdue (31 Dec 1999)"
  end

  it "does not raise if the date has not passed" do
    expect do
      DoBy::Note.new("note description", "31 Dec 2025")
    end.to_not raise_error
  end
end
