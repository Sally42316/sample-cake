class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
    
    # /admin/orders/:id 注文詳細画面(ステータス編集を兼ねる)
    def show
        @order = Order.find(params[:id])
        @order_details = @order.order_details
    end
    


    # /admin/orders/:id 注文ステータスの更新
    def update
        @order = Order.find(params[:id])
        @order.update(order_params)
        @order_details = @order.order_details
    # 1. 注文ステータスが「入金確認」に変更された場合
    if @order.status == "check_for_payment"
        # 製作ステータスを「製作待ち」に変更
        @order.order_details.update_all(making_status: "waiting_production")
      end
  
      # 2. 複数の商品があり、1つでも製作ステータスが「製作中」に変更された場合
      if @order.order_details.any? { |detail| detail.making_status == "making_production" }
        # 注文ステータスを「製作中」に変更
        @order.update(status: "in_production")
      end
  
      
  
      flash[:notice] = "注文詳細の更新に成功しました。"
      redirect_to admin_order_path(@order)
    end




    def order_params
        params.require(:order).permit(:status, :order_details)
    end
end