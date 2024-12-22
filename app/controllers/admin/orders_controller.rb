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
        if @order.status == "入金確認"
            @order_details.update_all(making_status: "製作待ち")
        end
        flash[:notice] = "注文詳細の更新に成功しました。"
        redirect_to admin_order_path(@order)
    end

    def order_params
        params.require(:order).permit(:status, :order_details)
    end
end