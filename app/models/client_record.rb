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
end
