class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    if params[:category_id] && Category.ids.include?(params[:category_id].to_i)
      @category = Category.find(params[:category_id])
      @products = @category.products
    else
      @products = Product.all
    end

    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(
                          name: params[:name],
                          description: params[:description],
                          price: params[:price],
                          image: params[:image],
                          category_id: params[:category_id]
    )

    if @product.save
      flash[:success] = "You created a new product!"
      redirect_to "/products/#{@product.id}"
    else
      @categories = Category.all
      flash[:error] = "Something went wrong."
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    
    if @product.update(name: params[:name],
                        description: params[:description],
                        price: params[:price],
                        image: params[:image],
                        category_id: params[:category_id]
      )
      flash[:success] = "You updated the product!"
      redirect_to "/products/#{@product.id}"
    else
      flash[:error] = "Something went wrong."
      @categories = Category.all
      render 'edit'
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    flash[:success] = "You destroyed the product."
    redirect_to "/products"
  end
end
