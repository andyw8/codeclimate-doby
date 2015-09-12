require "date"

module DoBy
  class LateTask < RuntimeError; end
  class NoDueDateTask < RuntimeError; end

  class Note
    def initialize(description, date = nil)
      fail NoDueDateTask, "missing due date" unless date

      if Date.parse(date) < Date.today
        fail LateTask, "#{description} is overdue (#{date})"
      end
    end
  end
end
