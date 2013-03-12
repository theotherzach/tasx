class DueDatesController < ApplicationController
  def index
    @due_dates = []
    @due_dates << DueDate.new
  end

  DueDate = Struct.new(:name, :next) do
    def name
      "Monthly Payroll"
    end

    def next
      "03-15-2013"
    end
  end
end
