class Menu < ApplicationRecord
  belongs_to :genre
  has_many :client_menus
end
