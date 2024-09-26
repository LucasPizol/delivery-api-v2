class OrdersController < ApplicationController
  before_action :set_order, only: %i[ update ]
  before_action -> { authorization([ "user" ]) }, except: %i[ index show ]

  def index
    if @current_user[:type] === "customer"
      @orders = Order.where(customer_id: @current_user[:id])
    elsif @current_user[:type] === "user"
      @orders = Order.where(company_id: @current_user[:id])
    end

    render json: @orders
  end

  def show
    if @current_user[:type] === "customer"
      @order = Order.where(customer_id: @current_user[:id],
                            id: params[:id]).first

    elsif @current_user[:type] === "user"
      @order = Order.where(company_id: @current_user[:id],
                            id: params[:id]).first
    end

    if @order.nil?
      return render json: { error: "Order not found" }, status: :not_found
    end

    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

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
      params.require(:order).permit(:status, :address_id, :company_id, :customer_id)
    end
end
