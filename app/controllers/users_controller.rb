class UsersController < ApplicationController
  before_action -> { authorization([ "user" ]) }

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy!
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :name, :document, :phone, :password, :password_confirmation, :createdAt, :updatedAt)
    end
end
