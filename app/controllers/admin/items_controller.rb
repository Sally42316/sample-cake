class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!

    # /admin/items
    def index
    @search = Item.ransack(params[:q])
    @items = @search.result.page(params[:page]).per(5)
    end
  
  # /admin/items/new
    def new
     @item = Item.new
    end
  
  # /admin/items
    def create
     @item = Item.new(item_params)
      if @item.save
     flash[:notice] = '登録成功'
      redirect_to admin_item_path(@item.id)
      else
     flash[:alert] = '登録error'
      render :new
      end
    end
  
  # /admin/items/:id
    def show
      @items = Item.find(params[:id])
    end
  
  # /admin/items/:id/edit
    def edit
      @items = Item.find(params[:id])
    end
  
  # /admin/items/:id
    def update
    @items = Item.find(params[:id])
     if @items.update(item_params)
      flash[:notice] = ' 更新成功'
      redirect_to admin_item_path(@items)
     else
      flash[:alert] = ' 更新error'
      redirect_to admin_item_path(@items)
     end
    end
  
    private
    def item_params
      params.require(:item).permit(:genre_id, :name, :introduction, :nontaxprice, :image, :is_sell_status)
    end
  end