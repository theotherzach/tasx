class DueDate < ActiveRecord::Base
  store_accessor :recur, :frequency
  store_accessor :recur, :day_of_week
  store_accessor :recur, :day_of_month
end
