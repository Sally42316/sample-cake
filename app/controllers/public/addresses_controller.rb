class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

def index
  @customer = current_customer
  @addresses = @customer.addresses
  @address = Address.new
end

def edit
  @address = Address.find(params[:id])
end

def create
  @address = Address.new(address_params)
  @address.customer_id = current_customer.id
  if @address.save
    redirect_to request.referer
  else
    redirect_to addresses_path ,alert: '新しい住所の情報が不足しています'
  end

end

def update
  address = Address.find(params[:id])
  address.update(address_params)
  redirect_to addresses_path
end

def destroy
  address = Address.find(params[:id])
  address.destroy
  redirect_to addresses_path
end


private

def address_params
  params.require(:address).permit(:post_code, :address, :name)
end
end