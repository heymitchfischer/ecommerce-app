class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  protect_from_forgery except: [:create]

  def index
    @orders = current_user.orders
  end

  def create
    endpoint_secret = "#{ENV["SIGNING_SECRET"]}"
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
        event = Stripe::Webhook.construct_event(
            payload, sig_header, endpoint_secret
        )
    rescue JSON::ParserError => e
        # Invalid payload
        render json: {status: 400}
        return
    rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        render json: {status: 400}
        return
    end

    # Do something with event


    user = User.find_by(email: params[:data][:object][:customer_email])
    order = Order.new(user_id: user.id)

    if user.products_in_cart.any? && order.save
      user.products_in_cart.update_all(order_id: order.id)
      render json: {status: 200}
    else
      render json: {status: 400}
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
