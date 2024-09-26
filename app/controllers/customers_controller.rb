class CustomersController < ApplicationController
  before_action -> { authorization([ "customer" ]) }
  skip_before_action :authorization, only: [ :create ]

  def update
    if @current_user.update(customer_params)
      render json: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy!
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :document, :phone, :email, :password, :password_confirmation)
    end
end
