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

genres = Genre.create([
   { name: 'ケーキ' },
   { name: '焼き菓子' },
  { name: 'プリン' },
   { name: 'キャンディ' }
 ])

 items = Item.create([
  { genre_id: genres[0].id, name: 'いちごのショートケーキ（ホール）', introduction: 'いちごのショートケーキです。(seeds.rb内記述)', nontaxprice: 2500, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/i_cake1.jpg"), filename: "i_cake1.jpg"), },
  { genre_id: genres[0].id, name: 'ガトーショコラ', introduction: 'ガトーショコラです。(seeds.rb内記述)', nontaxprice: 2800, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/i_cake2.jpg"), filename: "i_cake2.jpg"), },
  { genre_id: genres[1].id, name: 'クッキー', introduction: 'クッキーです。(seeds.rb内記述)', nontaxprice: 800, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/i_cookie1.jpg"), filename: "i_cookie1.jpg"), },
  { genre_id: genres[2].id, name: 'チョコプリン', introduction: 'チョコプリンです。(seeds.rb内記述)', nontaxprice: 600, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/i_pudding1.jpg"), filename: "i_pudding1.jpg"), },
  { genre_id: genres[3].id, name: '抹茶キャンディ', introduction: '抹茶のキャンディです(seeds.rb内記述)', nontaxprice: 700, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/i_candy1.png"), filename: "i_candy1.png"), },
  { genre_id: genres[0].id, name: 'チョコバナナミルフィーユ', introduction: 'チョコバナナミルフィーユです。(seeds.rb内記述)', nontaxprice: 1100, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/i_millefeuille1.png"), filename: "i_millefeuille1.png"), },
  { genre_id: genres[0].id, name: 'チーズタルト', introduction: 'チーズタルトです。(seeds.rb内記述)', nontaxprice: 330, is_sell_status: true, image: ActiveStorage::Blob.create_and_upload!(io: File.open("app/assets/images/i_cake3.jpg"), filename: "i_cake3.jpg"), },
])