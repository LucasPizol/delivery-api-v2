class OrderItemsController < ApplicationController
  def show
    @order_items = OrderItem.where(order_id: params[:id]).joins(:product)

    render json: @order_items.to_json(include: :product)
  end
end
