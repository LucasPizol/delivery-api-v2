class MotorcurierOrdersController < ApplicationController
  before_action :set_motorcurier_order, only: %i[ show update destroy ]

  # GET /motorcurier_orders
  def index
    @motorcurier_orders = MotorcurierOrder.where(motor_curier_id: @current_user[:id])
                                          .joins(:order)
                                          .where(orders: { status: "pending" })

    render json: @motorcurier_orders.to_json(include: :order)
  end

  # GET /motorcurier_orders/1
  def show
    render json: @motorcurier_order
  end

  # POST /motorcurier_orders
  def create
    @motorcurier_order = MotorcurierOrder.new(motorcurier_order_params)

    if @motorcurier_order.save
      render json: @motorcurier_order, status: :created, location: @motorcurier_order
    else
      render json: @motorcurier_order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /motorcurier_orders/1
  def update
    if @motorcurier_order.update(motorcurier_order_params)
      render json: @motorcurier_order
    else
      render json: @motorcurier_order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /motorcurier_orders/1
  def destroy
    @motorcurier_order.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motorcurier_order
      @motorcurier_order = MotorcurierOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def motorcurier_order_params
      params.require(:motorcurier_order).permit(:order_id, :motor_curier_id)
    end
end
