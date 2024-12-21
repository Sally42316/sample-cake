class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @order = Order.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_fee, :total_price)
  end
end
