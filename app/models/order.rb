
class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_details 



  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_for_payment: 0, check_for_payment: 1, in_production: 2, prep_to_ship: 3, shipped: 4 }
  
  def price
   (self.item.nontaxprice * 1.10).round
  end
end

