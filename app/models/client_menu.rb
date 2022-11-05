class ClientMenu < ApplicationRecord
  belongs_to :client
  belongs_to :menu
  belongs_to :client_records, optional: true
end
