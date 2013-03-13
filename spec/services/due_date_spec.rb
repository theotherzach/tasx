require_relative '../../app/services/due_date'
require 'active_support/time'

describe DueDate do
  before do
    Date.stub(:today) { Date.new(2013, 03, 11) }
  end

  it "annual CAT" do
    date = DueDate.new(name: "Annual CAT", frequency: :annual, recur_on: [5, 20])
    expect(date.next).to eq Date.parse("2013-05-20")
  end

  it "next year's CAT" do
    Date.stub(:today) { Date.new(2013, 06, 16) }
    date = DueDate.new(name: "Annual CAT", frequency: :annual, recur_on: [5, 20])
    expect(date.next).to eq Date.parse("2014-05-20")
  end

  it "Montly Sales" do
    date = DueDate.new(name: "Monthly Sales", frequency: :monthly, recur_on: [15])
    expect(date.next).to eq Date.parse("2013-03-15")
  end


  it "June Montly Sales" do
    Date.stub(:today) { Date.new(2013, 05, 16) }
    date = DueDate.new(name: "Monthly Sales", frequency: :monthly, recur_on: [15])
    expect(date.next).to eq Date.parse("2013-06-16")
  end

  it "quarterly" do
    date = DueDate.new(name: "Monthly Sales", frequency: :quarterly, recur_on: [1, 15])
    expect(date.next).to eq Date.parse("2013-04-15")
  end

  it "weekly" do
    date = DueDate.new(name: "Monthly Sales", frequency: :weekly, recur_on: [4])
    expect(date.next).to eq Date.parse("2013-03-14")
  end

  it "pukes if frequency isn't weekly, monthly, quarterly, or annual" do
    expect do
      date = DueDate.new name: "Haxxorz", frequency: :call, recur_on: [0]
      date.next
    end.to raise_error DueDate::UnknownFrequency
  end

  it "pukes if recur_on isn't an int and of proper size" do
    expect do
      date = DueDate.new name: "Haxxorz", frequency: :quarterly, recur_on: ["0"]
      date.next
    end.to raise_error DueDate::BadRecur
  end

  context "falls on weekend or holiday" do
    it "last business day before for school districts"
    it "next buisiness day for federal, state, and city"
  end
end
