class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def create
    order = Order.new(user_id: current_user.id)

    if current_user.products_in_cart.any? && order.save
      flash[:success] = "Order placed!"
      current_user.products_in_cart.update_all(order_id: order.id)
      redirect_to "/products"
    else
      flash[:error] = "Something went wrong."
      redirect_to "/"
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
