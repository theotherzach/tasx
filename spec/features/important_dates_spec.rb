require 'spec_helper'

def monthly_payroll_date(date = Date.today)
  if date.day <= 15
    fifteenth = date.at_beginning_of_month + 15.days
  else
    fifteenth = date.at_beginning_of_month.next_month + 15.days
  end
  while fifteenth.wday >= 6
    fifteenth = fifteenth - 1.days
  end
  fifteenth
end

feature 'Important dates' do
  scenario "are viewable in list format" do
    visit '/dates'
    expect(page).to have_content("Dates")
    expect(page).to have_content(monthly_payroll_date.strftime("%m-%d-%Y"))
  end

  scenario "update properly" do
    visit '/dates'
    Date.stub(:today) { Date.parse("05-16-2013") }
    expect(page).to have_content("06-14-2013")
  end

  scenario "cross refrences Montly Payroll with clients" do
    visit '/dates'
    expect(page).to have_content("Bob's Bobbers")
    expect(page).to have_content("Mike's Box")
  end
end
