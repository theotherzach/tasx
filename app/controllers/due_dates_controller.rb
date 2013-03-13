class DueDatesController < ApplicationController
  def index
    @due_dates = []
    @due_dates << DueDate.new(name: "Monthly Payroll", frequency: :monthly, recur_on: [15])
  end
  
  def new
  end
end
