require 'spec_helper'

feature 'Important dates' do
  scenario "are viewable in list format" do
    Date.stub(:today) { Date.new(2013, 3, 11) }
    visit '/dates'
    expect(page).to have_content("Dates")
    expect(page).to have_content("03-15-2013")
  end

  scenario "update properly" do
    Date.stub(:today) { Date.new(2013, 5, 16) }
    visit '/dates'
    expect(page).to have_content("06-16-2013")
  end

  scenario "cross refrences Montly Payroll with clients" do
    visit '/dates'
    expect(page).to have_content("Bob's Bobbers")
    expect(page).to have_content("Mike's Box")
  end

  scenario "creates new dates" do
    visit '/dates/new'
    # click_button 'new date'
  end

  scenario "adds clients to dates"
  scenario "removes clients from dates"
  scenario "deletes dates"
end
