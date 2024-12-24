class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

def show
  @customer = current_customer
end

def edit
  @customer = current_customer
end

def update
  @customer = current_customer
  if @customer.update(customer_params)
    flash[:notice] = "会員情報を編集しました。"
    redirect_to customers_mypage_path
  else
    render 'edit'
  end
end

def check
end

def withdraw
 @customer = Customer.find(current_customer.id)
 @customer.update(is_deleted: false)
 reset_session
 flash[:notice] = "退会処理を実行しました。"
 redirect_to root_path
end

private

def customer_params
  params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :address, :tell_number, :email)
end
end