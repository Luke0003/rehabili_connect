class AddRehabiliTimeOfTheDayToClientRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :client_records, :rehabili_time_of_the_day, :string, null: false, default: "0:0:0"
  end
end
