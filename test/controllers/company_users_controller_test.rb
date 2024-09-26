require "test_helper"

class CompanyUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_user = company_users(:one)
  end

  test "should get index" do
    get company_users_url, as: :json
    assert_response :success
  end

  test "should create company_user" do
    assert_difference("CompanyUser.count") do
      post company_users_url, params: { company_user: { company_id: @company_user.company_id, role: @company_user.role, user_id: @company_user.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show company_user" do
    get company_user_url(@company_user), as: :json
    assert_response :success
  end

  test "should update company_user" do
    patch company_user_url(@company_user), params: { company_user: { company_id: @company_user.company_id, role: @company_user.role, user_id: @company_user.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy company_user" do
    assert_difference("CompanyUser.count", -1) do
      delete company_user_url(@company_user), as: :json
    end

    assert_response :no_content
  end
end
