class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!
  
    def update
      @order_detail = OrderDetail.find(params[:id])
      @order = @order_detail.order  # 関連する注文を取得
  
      # 製作ステータスを更新
      if @order_detail.update(order_detail_params)
        
        # 1. 製作ステータスが「製作中」に変更された場合、注文ステータスを「製作中」に変更
        if @order_detail.making_status == "making_production"
          # 注文詳細の1つでも製作ステータスが「製作中」であれば注文ステータスを「製作中」に変更
          @order.update(status: "in_production")
        end
  
        # 2. 製作ステータスが「製作完了」に変更された場合、すべての注文詳細が「製作完了」であれば注文ステータスを「発送準備中」に変更
        if @order_detail.making_status == "finished"
          # すべての注文詳細の製作ステータスが「製作完了」の場合
          if @order.order_details.all? { |detail| detail.making_status == "finished" }
            @order.update(status: "prep_to_ship")
          end
        end
  
        flash[:notice] = "注文詳細の更新に成功しました。"
      else
        flash[:alert] = "注文詳細の更新に失敗しました。"
      end
  
      redirect_to admin_order_path(@order)
    end
  
    private
  
    def order_detail_params
      params.require(:order_detail).permit(:making_status)
    end
  end