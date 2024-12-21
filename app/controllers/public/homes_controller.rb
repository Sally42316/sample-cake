class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @items = Item.where(is_sell_status: true).order(created_at: :desc).limit(4)
  end

# GET	/about
  def about
  end
  
end
