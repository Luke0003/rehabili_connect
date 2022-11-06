class ClientMenu < ApplicationRecord
  belongs_to :client
  belongs_to :menu
  belongs_to :client_records, optional: true # 外部キーを持たない状態でのレコード保存を許容
end
