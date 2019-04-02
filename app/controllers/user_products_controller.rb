class UserProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items_in_cart = current_user.user_products
  end

  def create
    carted_item = UserProduct.new(
                                  product_id: params[:product_id],
                                  user_id: current_user.id,
                                  removed_from_cart: false
      )

    if carted_item.save
      flash[:success] = "Added to cart!"
      redirect_to "/products"
    else
      flash[:error] = "Something went wrong."
      redirect_to "/products"
    end
  end
end
