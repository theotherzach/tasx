class DueDate
  attr_accessor :name
  def initialize(name: name, recur_on: recur_on, frequency: frequency)
    @name = name
    @recur_on = recur_on
    @frequency = frequency
  end

  def next
    method(@frequency).call
  end

  def annual(date = Date.today)
    if date.day <= @recur_on[1] && date.month <= @recur_on[0]
      year = date.year
    else
      year = date.year + 1
    end
    un_weekend!(Date.new(year, @recur_on[0], @recur_on[1]))
  end

  def monthly(date = Date.today)
    if date.day <= @recur_on[0]
      target_date = date.at_beginning_of_month + (@recur_on[0] - 1)
    else
      target_date = date.at_beginning_of_month.next_month + (@recur_on[0] - 1)
    end
    un_weekend!(target_date)
  end

  def un_weekend!(date)
    while date.wday >= 6
      date = date + 1.days
    end
    date
  end
end
