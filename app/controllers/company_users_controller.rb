class CompanyUsersController < ApplicationController
  before_action :set_company_user, only: %i[ show update destroy ]

  # GET /company_users
  def index
    @company_users = CompanyUser.all

    render json: @company_users
  end

  # GET /company_users/1
  def show
    render json: @company_user
  end

  # POST /company_users
  def create
    @company_user = CompanyUser.new(company_user_params)

    if @company_user.save
      render json: @company_user, status: :created, location: @company_user
    else
      render json: @company_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /company_users/1
  def update
    if @company_user.update(company_user_params)
      render json: @company_user
    else
      render json: @company_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /company_users/1
  def destroy
    @company_user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_user
      @company_user = CompanyUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_user_params
      params.require(:company_user).permit(:company_id, :user_id, :role)
    end
end
