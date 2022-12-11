class Therapist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, invite_for: 24.hours, validate_on_invite: true

  has_many :clients
  has_many :chats
  has_many :rooms
  has_many :notifications
  has_one_attached :therapist_image

  validates :last_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/,message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :first_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/, message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :last_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}
  validates :first_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}

  # セラピスト画像を取得しリサイズ
  def get_therapist_image(width, height)
    unless therapist_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      therapist_image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpeg")
    end
    therapist_image.variant(resize_to_fill: [width, height]).processed
  end
  
  # フルネーム(カタカナも可)を返すモジュール
  include UserFullName
end
