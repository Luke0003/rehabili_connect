class Room < ApplicationRecord
  has_many :chats
  belongs_to :therapist
  belongs_to :client
end
