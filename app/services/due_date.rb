class DueDate
  class UnknownFrequency < RuntimeError; end
  class BadRecur < RuntimeError; end

  attr_accessor :name, :recur_on, :frequency

  def initialize(name: name, recur_on: recur_on, frequency: frequency)
    @name = name || ""
    @recur_on = recur_on || []
    @frequency = frequency || :not_set
  end

  def next
    guard_frequency
    guard_recur
    un_weekend! method(@frequency).call
  end

  private
  def annual(date = Date.today)
    guard_recur 1
    if date.day <= @recur_on[1] && date.month <= @recur_on[0]
      year = date.year
    else
      year = date.year + 1
    end
    Date.new year, @recur_on[0], @recur_on[1]
  end

  def quarterly(date = Date.today)
    guard_recur 1
    month = @recur_on[0] % 3
    target_date = date.beginning_of_quarter + (month - 1).months + (@recur_on[1] - 1) .days
    target_date + 3.months if target_date < date
  end

  def monthly(date = Date.today)
    if date.day <= @recur_on[0]
      target_date = date.at_beginning_of_month + (@recur_on[0] - 1)
    else
      target_date = date.at_beginning_of_month.next_month + (@recur_on[0] - 1)
    end
  end

  def weekly(date = Date.today)
    target_date = date
    while target_date.wday != @recur_on[0]
      target_date = target_date + 1.days
    end
    target_date
  end

  def un_weekend!(date)
    while date.wday >= 6
      date = date + 1.days
    end
    date
  end

  def guard_frequency
    unless %i[annual quarterly monthly weekly].include? @frequency
      raise UnknownFrequency
    end
  end

  def guard_recur(index = 0)
    raise BadRecur, "@recur_on does not respond to []" unless @recur_on.respond_to? :[]
    unless @recur_on[index].class == Fixnum
      raise BadRecur, "@recur_on[#{index}] requires integers"
    end
  end
end
