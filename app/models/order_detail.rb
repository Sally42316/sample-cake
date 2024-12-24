class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item
  
    enum making_status: { not_create: 0, waiting_production: 1, making_production: 2, finished: 3 }
    
    def price
     (self.item.nontaxprice * 1.10).round
    end
end
