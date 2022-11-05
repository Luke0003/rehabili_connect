class ClientRecord < ApplicationRecord
  belongs_to :client
  has_many :client_menus
end
