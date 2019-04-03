class UserProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items_in_cart = current_user.products_in_cart
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

  def destroy
    item_in_cart = UserProduct.find(params[:id])
    item_in_cart.update(removed_from_cart: true)
    flash[:success] = "Product removed from cart."
    redirect_to "/cart"
  end
end
