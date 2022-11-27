# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: ENV['SECRET_ADMIN_EMAIL'],
  password: ENV['SECRET_ADMIN_PASSWORD']
)

Therapist.create!(
  email: ENV['SECRET_THERAPIST_EMAIL'], password: ENV['SECRET_THERAPIST_PASSWORD'], last_name: "東京", first_name: "太郎",
  last_name_kana: "トウキョウ", first_name_kana: "タロウ",
  therapist_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/portrait-3353699_640.jpg"), filename:"portrait-3353699_640.jpg")
)

Client.create!(
  email: ENV['SECRET_CLIENT_EMAIL'], password: ENV['SECRET_CLIENT_PASSWORD'], last_name: "大阪", first_name: "次郎",
  last_name_kana: "オオサカ", first_name_kana: "ジロウ", therapist_id: 1,
  purpose: "買い物に一人で行けるようになる", prefecture: "osaka",
  client_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/beard-1845166_640.jpg"), filename:"beard-1845166_640.jpg")
)

genres = ["上肢", "下肢", "体幹"]

genres.each do |genre_name|
  Genre.create!(genre_name: genre_name)
end

menus = [
  [1, "肩の上下運動", "肩の力を抜いて座り、息を吸いながら両肩をあげ(すぼめ)、息を吐きながらストンと両肩を下ろしてください。(1セット5回)", "僧帽筋のリラックス"],
  [2, "つま先上げ", "膝を90度に曲げて椅子に座り、踵をつけたままつま先を上げてください。(1セット10回)", "前脛骨筋の強化"],
  [3, "ヒップリフト", "仰向けに寝た状態で膝を90度に立て、肩・腰・膝が一直線になるように腰を上げてください。(1セット10回)", "大臀筋の強化"]
]

menus.each do |genre_id, menu_name, menu_content, menu_purpose|
  Menu.create!(genre_id: genre_id, menu_name: menu_name, menu_content: menu_content, menu_purpose: menu_purpose)
end

Menu.find(1).menu_video.attach(io: File.open(Rails.root.join('app/assets/videos/IMG_8225.mp4')), filename: 'IMG_8225.mp4')

prefectures = [
  ["北海道", 43.06417, 141.34694], ["青森", 40.82444, 140.74], ["岩手", 39.70361, 141.1525], ["宮城", 38.26889, 140.87194], ["秋田", 39.71861, 140.1025],
  ["山形", 38.24056, 140.36333], ["福島", 37.75, 140.46778], ["茨城", 36.34139, 140.44667], ["栃木", 36.56583, 139.88361], ["群馬", 36.39111, 139.06083],
  ["埼玉", 35.85694, 139.64889], ["千葉", 35.60472, 140.12333], ["東京", 35.68944, 139.69167], ["神奈川", 35.44778, 139.6425], ["新潟", 37.90222, 139.02361],
  ["富山", 36.69528, 137.21139], ["石川", 36.59444, 136.62556], ["福井", 36.06528, 136.22194], ["山梨", 35.66389, 138.56833], ["長野", 36.65139, 138.18111],
  ["岐阜", 35.39111, 136.72222], ["静岡", 34.97694, 138.38306], ["愛知", 35.18028, 136.90667], ["三重", 34.73028, 136.50861], ["滋賀", 35.00444, 135.86833],
  ["京都", 35.02139, 135.75556], ["大阪", 34.68639, 135.52], ["兵庫", 34.69139, 135.18306], ["奈良", 34.68528, 135.83278], ["和歌山", 34.22611, 135.1675],
  ["鳥取", 35.50361, 134.23833], ["島根", 35.47222, 133.05056], ["岡山", 34.66167, 133.935], ["広島", 34.39639, 132.45944], ["山口", 34.18583, 131.47139],
  ["徳島", 34.06583, 134.55944], ["香川", 34.34028, 134.04333], ["愛媛", 33.84167, 132.76611], ["高知", 33.55972, 133.53111], ["福岡", 33.60639, 130.41806],
  ["佐賀", 33.24944, 130.29889], ["長崎", 32.74472, 129.87361], ["大分", 33.23806, 131.6125], ["熊本", 32.78972, 130.74167], ["宮崎", 31.91111, 131.42389],
  ["鹿児島", 31.56028, 130.55806], ["沖縄", 26.2125, 127.68111]
]

prefectures.each do |prefecture_name, latitude, longitude|
  Prefecture.create!(prefecture_name: prefecture_name, latitude: latitude, longitude: longitude)
end