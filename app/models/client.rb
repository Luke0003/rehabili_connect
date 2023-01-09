class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, invite_for: 24.hours, validate_on_invite: true

  belongs_to :therapist
  has_many :client_records
  has_many :client_menus
  has_many :chats
  has_many :notifications
  has_many :rehabili_times
  has_one :room
  has_one_attached :client_image

  enum prefecture: {
    hokkaido: 0, aomori: 1, iwate: 2, miyagi: 3, akita: 4, yamagata: 5, fukushima: 6, ibaraki: 7, tochigi: 8, gunma: 9,
    saitama: 10, chiba: 11, tokyo: 12, kanagawa: 13, niigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano: 19,
    gifu: 20, shizuoka: 21, aichi: 22, mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27, nara: 28, wakayama: 29,
    tottori: 30, shimane: 31, okayama: 32, hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36, ehime: 37, kochi: 38, fukuoka: 39,
    saga: 40, nagasaki: 41, oita: 42, kumamoto: 43, miyazaki: 44, kagoshima: 45, okinawa: 46
  }


  validates :last_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/,message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :first_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/, message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :last_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}
  validates :first_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}
  validates :purpose, presence: true
  validates :prefecture, presence: true

  # クライアント画像を取得しリサイズ
  def get_client_image(width, height)
    unless client_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      client_image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpeg")
    end
    client_image.variant(resize_to_fill: [width, height]).processed
  end

   # フルネーム(カタカナも可)を返すモジュール
  include UserFullName
end
