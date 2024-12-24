Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

Customer.create!(
  email: 'customer1@example.com',
  password: 'customer1',
  family_name: '顧客',
  first_name: '一号',
  family_name_kana: 'コキャク',
  first_name_kana: 'イチゴウ',
  post_code: '0000000',
  tell_number: '00000000000',
  address: 'サンプル県サンプル市サンプル島１丁目'
)

# genres = Genre.create([
#    { name: 'ケーキ' },
#    { name: '焼き菓子' },
#   { name: 'プリン' },
#    { name: 'キャンディ' }
#  ])

#  items = Item.create([
#   { genre_id: genres[0].id, name: 'いちごのショートケーキ', introduction: 'いちごのショートケーキです。(seeds.rb内記述)', nontaxprice: 600, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/short_cake.jpg"), filename: "short_cake.jpg"), },
#   { genre_id: genres[0].id, name: 'ガトーショコラ', introduction: 'ガトーショコラです。(seeds.rb内記述)', nontaxprice: 800, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/chocolat.jpg"), filename: "chocolat.jpg"), },
#   { genre_id: genres[1].id, name: 'クッキー', introduction: 'クッキーです。(seeds.rb内記述)', nontaxprice: 800, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/cookie.jpg"), filename: "cookie.jpg"), },
#   { genre_id: genres[2].id, name: 'チョコプリン', introduction: 'チョコプリンです。(seeds.rb内記述)', nontaxprice: 600, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/pudding.jpg"), filename: "pudding.jpg"), },
#   { genre_id: genres[3].id, name: '抹茶キャンディ', introduction: '抹茶のキャンディです(seeds.rb内記述)', nontaxprice: 700, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/candy.jpg"), filename: "candy.jpg"), },
#   { genre_id: genres[0].id, name: '苺のミルフィーユ', introduction: '苺のミルフィーユです。(seeds.rb内記述)', nontaxprice: 1100, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/millefeuille.png"), filename: "millefeuille.png"), },
#   { genre_id: genres[0].id, name: 'チーズタルト', introduction: 'チーズタルトです。(seeds.rb内記述)', nontaxprice: 330, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/cheese.jpg"), filename: "cheese.jpg"), },
# ])