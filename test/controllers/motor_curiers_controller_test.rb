require "test_helper"

class MotorCuriersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @motor_curier = motor_curiers(:one)
  end

  test "should get index" do
    get motor_curiers_url, as: :json
    assert_response :success
  end

  test "should create motor_curier" do
    assert_difference("MotorCurier.count") do
      post motor_curiers_url, params: { motor_curier: { code: @motor_curier.code, lat: @motor_curier.lat, lng: @motor_curier.lng, name: @motor_curier.name } }, as: :json
    end

    assert_response :created
  end

  test "should show motor_curier" do
    get motor_curier_url(@motor_curier), as: :json
    assert_response :success
  end

  test "should update motor_curier" do
    patch motor_curier_url(@motor_curier), params: { motor_curier: { code: @motor_curier.code, lat: @motor_curier.lat, lng: @motor_curier.lng, name: @motor_curier.name } }, as: :json
    assert_response :success
  end

  test "should destroy motor_curier" do
    assert_difference("MotorCurier.count", -1) do
      delete motor_curier_url(@motor_curier), as: :json
    end

    assert_response :no_content
  end
end
