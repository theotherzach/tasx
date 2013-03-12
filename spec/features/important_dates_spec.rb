require 'spec_helper'

feature 'Important dates' do
  scenario "are viewable in list format" do
    visit '/dates'
    Date.stub(:today) { Date.parse("03-11-2013") }
    expect(page).to have_content("Dates")
    expect(page).to have_content("03-15-2013")
  end

  scenario "update properly" do
    pending "use real Date data"
    visit '/dates'
    Date.stub(:today) { Date.parse("05-16-2013") }
    expect(page).to have_content("06-16-2013")
  end

  scenario "cross refrences Montly Payroll with clients" do
    visit '/dates'
    expect(page).to have_content("Bob's Bobbers")
    expect(page).to have_content("Mike's Box")
  end
end
