require "./app/services/jwt_service.rb"

class AuthenticationController < ApplicationController
  skip_before_action :authorization, only: [ :login ]

  def login
    user = Customer.find_by(email: login_params[:email])
    if user.nil?
      return render json: { message: "Email or password is incorrect" }, status: :unauthorized
    end

    begin
      if user.authenticate(login_params[:password])
        token = JwtService.new.encode({ customer_id: user[:id] })

        render json: {
          id: user[:id],
          name: user[:name],
          email: user[:email],
          phone: user[:phone],
          document: user[:document],
          token: token
        }, status: :ok
      end

    rescue JWT::EncodeError
      render json: { message: "Email or password is incorrect" }, status: :unauthorized

    end
  end


  def login_params
    params.permit(:email, :password)
  end
end
