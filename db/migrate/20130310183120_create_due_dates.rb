class CreateDueDates < ActiveRecord::Migration
  def change
    create_table :due_dates do |t|
      t.string :name
      t.text :description
      t.date :start
      t.string :tags, array: true
      t.hstore :recur

      t.timestamps
    end
  end
end
