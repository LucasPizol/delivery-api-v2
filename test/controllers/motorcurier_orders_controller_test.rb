require "test_helper"

class MotorcurierOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @motorcurier_order = motorcurier_orders(:one)
  end

  test "should get index" do
    get motorcurier_orders_url, as: :json
    assert_response :success
  end

  test "should create motorcurier_order" do
    assert_difference("MotorcurierOrder.count") do
      post motorcurier_orders_url, params: { motorcurier_order: { motor_curier_id: @motorcurier_order.motor_curier_id, order_id: @motorcurier_order.order_id } }, as: :json
    end

    assert_response :created
  end

  test "should show motorcurier_order" do
    get motorcurier_order_url(@motorcurier_order), as: :json
    assert_response :success
  end

  test "should update motorcurier_order" do
    patch motorcurier_order_url(@motorcurier_order), params: { motorcurier_order: { motor_curier_id: @motorcurier_order.motor_curier_id, order_id: @motorcurier_order.order_id } }, as: :json
    assert_response :success
  end

  test "should destroy motorcurier_order" do
    assert_difference("MotorcurierOrder.count", -1) do
      delete motorcurier_order_url(@motorcurier_order), as: :json
    end

    assert_response :no_content
  end
end
