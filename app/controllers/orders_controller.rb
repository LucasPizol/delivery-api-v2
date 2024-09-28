class OrdersController < ApplicationController
  before_action :set_order, only: %i[ update ]
  def index
    @orders = Order.where(company_id: @current_user[:company_id])

    render json: @orders
  end

  def show
    @order = Order.where(company_id: @current_user[:id],
                          id: params[:id]).first

    if @order.nil?
      return render json: { error: "Order not found" }, status: :not_found
    end

    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(
      company_id: @current_user[:company_id],
      status: order_params[:status],
      address: order_params[:address],
      lat: order_params[:lat],
      lng: order_params[:lng],
      payment_method: order_params[:payment_method]
    )

    puts order_params

    order_params[:product_ids].each do |product_id|
      product = Product.find(product_id)

      if product.nil?
        return render json: { error: "Product not found" }, status: :not_found
      end

      order_items = OrderItem.new(
        quantity: 1, price: product.price
      )
      order_items.product = product
      order_items.order = @order
      order_items.save
    end

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.permit(:status, :address, :lat, :lng, :payment_method, :observation, product_ids: [])
    end
end
