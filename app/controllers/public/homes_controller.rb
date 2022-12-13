class Public::HomesController < ApplicationController
  before_action :authenticate_client!
  def top
    @client_menus = current_client.client_menus
    # カレンダーに紐付けることを目的とし、ハッシュを生成
    @conditions = ClientRecord.gen_hash_k_record_date_v_condition(current_client)
  end
end
