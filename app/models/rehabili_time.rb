class RehabiliTime < ApplicationRecord
  belongs_to :client

  # 特定の日のリハビリ時間の配列を取得
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

  # リハビリ時間を秒数に変換
  def self.rehabili_time_to_sec(array)
    rehabili_time_sec = array[0] * 360 + array[1] * 60 + array[2]
  end

  # 2日間のリハビリ合計時間の比率を取得
  def self.per_of_two_day(day1, day2)
    if day2 == 0
      "前日のリハビリ合計時間が0のため計算できません"
    else
      ((day1 / day2 * 100).round).to_s + "%"
    end
  end

  def self.rehabili_time_to_sentence(array)
    array[0].to_s + "時間" + array[1].to_s + "分" + array[2].to_s + "秒"
  end

  # これまでのリハビリ合計時間を取得
  def self.total_rehabili_time(client)
    rehabili_times = client.rehabili_times.all
    total_rehabili_time = [0, 0, 0]
    rehabili_times.each do |rehabili_time|
      for i in 0..2
        total_rehabili_time[i] = total_rehabili_time[i] + rehabili_time.record_time.split(":").map(&:to_i)[i]
      end
    end
    return total_rehabili_time
  end
end
