class ClientRecord < ApplicationRecord
  belongs_to :client
  has_many :client_menus

  # conditionの表示を数値から文字列に変える
  def condition_to_string
    if self.condition == 1
      @condition_status = "良い"
    elsif self.condition == 2
      @condition_status = "普通"
    else
      @condition_status = "悪い"
    end
    return @condition_status
  end

   # キーを登録記録日、バリューを体調としたハッシュを取得
  def self.gen_hash_k_record_date_v_condition(client)
    client_records = ClientRecord.where(client_id: client.id)
    conditions = {}
    client_records.each do |client_record|
      conditions[client_record.record_date] = client_record.condition
    end
    return conditions
  end

  # ◯時間△分×秒という形でその日のリハビリ時間を取得
  def get_rehabili_time_of_the_day_for_display
    array = self.rehabili_time_of_the_day.split(":")
    return array[0] + "時間" + array[1] + "分" + array[2] + "秒"
  end

end
