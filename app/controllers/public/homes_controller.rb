class Public::HomesController < ApplicationController
  before_action :authenticate_client!
  def top
    @client_menus = current_client.client_menus
    @client_records = current_client.client_records
    # キーを登録記録日、バリューを体調としたハッシュを取得
    @conditions = {}
    @client_records.each do |client_record|
      @conditions[client_record.record_date] = client_record.condition
    end
  end
end
