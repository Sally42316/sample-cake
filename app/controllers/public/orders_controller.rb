class Public::OrdersController < ApplicationController
  class Public::OrdersController < ApplicationController
    before_action :authenticate_customer!
    before_action :cart_items_blank?, only: [:new]
    before_action :payment_method_blank?, only: [:confirm, :create]
   
  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
    # @order = Order.find(params[:id])
    # @order_details = @order.order_details.includes(:item)
    # @order_details= OrderDetail.where(order_id: @order.id)


  end


  def confirm
    @customer = current_customer
    @cart_items = @customer.cart_items
    @order = Order.new
    @order.shipping_fee = 800
    @address = Address.find_by(id: params[:order][:selected_address].to_i)
    @order.payment_method = params[:order][:payment_method]
    # if params[:order][:address] == "my_address"
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.family_name + current_customer.first_name
    # elsif params[:order][:address] == "select_address" && params[:order][:selected_address].empty?
    elsif params[:order][:select_address] == "1"
      redirect_to new_order_path, alert: '配送先を選択してください'
    # elsif params[:order][:address] == "new_address" && params[:new_address].any? { |address| address["post_code"].empty? || address["address"].empty? || address["name"].empty? }
     
      redirect_to new_order_path, alert: '新しいお届け先の情報が不足しています'
    end
  end


  def thanx
  end


  def create
    @customer = current_customer
    @cart_items = @customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 'waiting_for_payment' 
    if @order.save
      @cart_items.each do |cart_item|
        order_detail = @order.order_details.new
      
        order_detail.item_id=cart_item.item_id,
        order_detail.price=cart_item.item.price,
        order_detail.amount=cart_item.amount
        order_detail.save 
      end
      # カートを空にする処理（注文が完了した後はカートをクリア）
      @cart_items.destroy_all
      redirect_to orders_thanx_path
    else
      redirect_to root_path, alert: 'カートが空です'
    end
  end


  def index
    @orders = Order.where(customer_id: current_customer.id)
    @order_details = OrderDetail.all
  end


  def show
    # @order = Order.find_by(id: params[:id])
    # ↑旧@order = Order.find(params[:id])
    @order = Order.find(params[:id])
    # @order_details = @order.order_details.includes(:item)
    # @order_details= OrderDetail.where(order_id: @order.id)
  end




  private


  def order_params
    # order_params = params.require(:order).permit(:customer_id, :name, :address, :post_code, :payment_method, :total_price, :shipping_fee, :status)
    # order_params[:payment_method] = order_params[:payment_method].to_i if order_params.key?(:payment_method)
    # order_params[:status] = order_params[:status].to_i if order_params.key?(:status)
    # order_params.permit(:customer_id, :name, :address, :post_code, :payment_method, :total_price, :shipping_fee, :status)
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_fee, :total_price)
  end


  def order_detail_params
    order_details = params.require(:order_detail)
    permitted_params = order_details.map do |order_detail|
      order_detail.permit(:item_id, :price, :amount, :making_status)
    end
    permitted_params
  end


  def cart_items_blank?
    if CartItem.all.blank?
      redirect_to root_path, alert: 'カートが空です'
    end
  end


  def payment_method_blank?
    if params[:order].nil? || params[:order][:payment_method].blank?
      redirect_to root_path, alert: "リンクが無効です"
    end
  end
end
end