require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get companies_url, as: :json
    assert_response :success
  end

  test "should create company" do
    assert_difference("Company.count") do
      post companies_url, params: { company: { document: @company.document, name: @company.name, phone: @company.phone } }, as: :json
    end

    assert_response :created
  end

  test "should show company" do
    get company_url(@company), as: :json
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: { document: @company.document, name: @company.name, phone: @company.phone } }, as: :json
    assert_response :success
  end

  test "should destroy company" do
    assert_difference("Company.count", -1) do
      delete company_url(@company), as: :json
    end

    assert_response :no_content
  end
end
