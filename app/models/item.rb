class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  has_one_attached :image

  validates :image,         presence: true
  validates :name,          presence: true
  validates :introduction,  presence: true
  validates :genre_id,      presence: true
  validates :nontaxprice,         presence: true
  validates :is_sell_status,     inclusion: [true, false]

    def price
        (self.nontaxprice * 1.10).round
    end

  def self.ransackable_attributes(auth_object = nil)
    ['name']
  end

  def get_image
   unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
      image
  end
end
