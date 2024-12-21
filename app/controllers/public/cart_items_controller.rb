class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  # GET	/cart_items
  def index
    @cart_items = current_customer.cart_items.includes(:item) # 現在の顧客のカートアイテムを取得
  end

# PATCH	/cart_items/:id
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(amount: params[:amount]) # 数量を更新
      redirect_to cart_items_path, notice: '数量が更新されました'
    else
      redirect_to cart_items_path, alert: '数量の更新に失敗しました'
    end
  end

# DELETE	/cart_items/:id
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: '商品がカートから削除されました' # カートの一覧ページにリダイレクト
  end

# DELETE	/cart_items/all_destroy
  def all_destroy
    current_customer.cart_items.destroy_all # 現在の顧客のカートアイテムをすべて削除
    redirect_to cart_items_path, notice: 'カートが空になりました'
  end

# POST  /cart_items
def create
  if customer_signed_in?
    handle_cart_item(params[:item_id], params[:amount].to_i)
  else
    flash[:alert] = "ログインしてください。"
    redirect_to item_path(params[:item_id])
  end
end

private

def handle_cart_item(item_id, amount)
  return redirect_to item_path(item_id), alert: '個数を選択してください' if amount <= 0
  
  existing_cart_item = current_customer.cart_items.find_by(item_id: item_id)

  if existing_cart_item
    update_existing_cart_item(existing_cart_item, amount)
  else
    create_new_cart_item(item_id, amount)
  end
end

def update_existing_cart_item(existing_cart_item, amount)
  new_amount = existing_cart_item.amount + amount

    existing_cart_item.amount = new_amount
    if existing_cart_item.save
      redirect_to cart_items_path, notice: 'カート内の商品の数量が更新されました'
    else
      redirect_to item_path(existing_cart_item.item_id), alert: '商品の数量を更新できませんでした'
    end
  end
end

def create_new_cart_item(item_id, amount)
    @cart_item = CartItem.new(item_id: item_id, amount: amount, customer_id: current_customer.id)
    if @cart_item.save
      redirect_to cart_items_path, notice: '商品がカートに追加されました'
    else
      redirect_to item_path(item_id), alert: '商品をカートに追加できませんでした'
    end
  end