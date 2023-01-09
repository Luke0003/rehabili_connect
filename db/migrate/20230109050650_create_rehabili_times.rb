class CreateRehabiliTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :rehabili_times do |t|
      t.string :record_time, null: false
      t.integer :client_id, null: false

      t.timestamps
    end
  end
end
