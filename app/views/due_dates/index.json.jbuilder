json.array!(@due_dates) do |due_date|
  json.extract! due_date, :name, :description, :start, :tags, :recur
  json.url due_date_url(due_date, format: :json)
end