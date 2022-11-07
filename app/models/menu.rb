class Menu < ApplicationRecord
  belongs_to :genre
  has_many :client_menus
  has_one_attached :menu_video

  validates :menu_name, presence: true, uniqueness: true
  validates :menu_content, presence: true
  validates :menu_purpose, presence: true
end
