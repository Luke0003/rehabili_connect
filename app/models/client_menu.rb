class ClientMenu < ApplicationRecord
  belongs_to :client
  belongs_to :menu
  belongs_to :client_record, optional: true # 外部キーを持たない状態でのレコード保存を許容

  validates :start_date, presence: true

  # is_completedのを真偽値から文字列に変える
  def is_completed_to_string
    if self.is_completed == true
      @client_menu_status = "達成"
    else
      @client_menu_status = "未達成"
    end
    return @client_menu_status
  end

  # client_recordに紐づいたclient_menusの完了ステータスの合計値を算出
  def self.is_completed_count(client_record)
    @count = 0
    client_menus = ClientMenu.where(client_record: client_record.id)
    client_menus.each do |client_menu|
      if client_menu.is_completed == true
        @count += 1
      end
    end
    return @count
  end

  # 実施したメニューのステータスを更新
  def self.update_is_completed(hash_client_menus)
    hash_client_menus.each do |key, value|
      ClientMenu.find(key).update(is_completed: value)
    end
  end

  # client_menuのclient_record_idを更新
  def self.update_client_record_id(hash_client_menus, client_record_id)
    hash_client_menus.each do |key, value|
      ClientMenu.find(key).update(client_record_id: client_record_id)
    end
  end

end
