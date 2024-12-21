class Public::ItemsController < ApplicationController
  # GET	/items
  def index
    @genres = Genre.all
    # @search = Item.ransack(params[:q])  # 検索オブジェクト作成

    # ジャンルが選択されている場合
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @search_items = @genre.items.where(is_sell_status: true)
    else
      @search_items = Item.where(is_sell_status: true)
    end

    # 検索条件がある場合、検索結果で絞り込む
    if params[:q].present?
      @search_items = @search.result.where(is_sell_status: true)
    end

    @total_items = @search_items.count
    @items = @search_items.page(params[:page]).per(8)  # ページネーション対応
  end

  # GET /items/:id
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

 private

  # 検索用のパラメータを許可
  def set_search
    @search = Item.ransack(params[:q])
  end
end