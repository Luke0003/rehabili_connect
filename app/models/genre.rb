class Genre < ApplicationRecord
  has_many :menus

  validates :genre_name, presence: true, uniqueness: true
end
