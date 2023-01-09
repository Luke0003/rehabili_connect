class RehabiliTime < ApplicationRecord
  belongs_to :client

  # 今日のリハビリ時間の配列を取得
  def self.array_rehabili_time_of_the_day(client, day)
    array = [0, 0, 0]
    rehabili_times = []
    client.rehabili_times.select do |rehabili_time|
      rehabili_times << rehabili_time if day.all_day.cover? rehabili_time.created_at
    end
    rehabili_times.each do |rehabili_time|
      for i in 0..2
        array[i] = array[i] + rehabili_time.record_time.split(":").map(&:to_i)[i]
      end
    end
    return array
  end

  # 記録用の表示形式に変更して取得
  def self.get_rehabili_time_of_the_day_for_record(array)
    str = ""
    for i in 0..1
      str += array[i].to_s + ":"
    end
    str += array[2].to_s
    return str
  end

end
