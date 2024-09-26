require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_item = order_items(:one)
  end

  test "should get index" do
    get order_items_url, as: :json
    assert_response :success
  end

  test "should create order_item" do
    assert_difference("OrderItem.count") do
      post order_items_url, params: { order_item: { order_id: @order_item.order_id, price: @order_item.price, product_id: @order_item.product_id, quantity: @order_item.quantity } }, as: :json
    end

    assert_response :created
  end

  test "should show order_item" do
    get order_item_url(@order_item), as: :json
    assert_response :success
  end

  test "should update order_item" do
    patch order_item_url(@order_item), params: { order_item: { order_id: @order_item.order_id, price: @order_item.price, product_id: @order_item.product_id, quantity: @order_item.quantity } }, as: :json
    assert_response :success
  end

  test "should destroy order_item" do
    assert_difference("OrderItem.count", -1) do
      delete order_item_url(@order_item), as: :json
    end

    assert_response :no_content
  end
end
