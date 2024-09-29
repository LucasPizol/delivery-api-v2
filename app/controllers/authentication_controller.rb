require "./app/services/jwt_service.rb"

class AuthenticationController < ApplicationController
  skip_before_action :authorization, only: [ :login, :register, :authenticate_motor_curier ]

  def login
    user = User.find_by(email: login_params[:email])

    if user.nil?
      return render json: { message: "Email or password is incorrect" }, status: :unauthorized
    end

    begin
      if user.authenticate(login_params[:password])
        token = JwtService.new.encode({ id: user[:id] })

       return render json: {
          id: user[:id],
          name: user[:name],
          email: user[:email],
          phone: user[:phone],
          document: user[:document],
          token: token
        }, status: :ok
      end

      render json: { message: "Email or password is incorrect" }, status: :unauthorized

    rescue JWT::EncodeError
      render json: { message: "Email or password is incorrect" }, status: :unauthorized

    rescue
      render json: { message: "Email or password is incorrect" }, status: :unauthorized
    end
  end

  def register
    user = User.new(register_params[:user])
    company = Company.new(register_params[:company])
    address = Address.new(register_params[:address])
    user.company = company
    company.address = address

    if company.save
      token = JwtService.new.encode({ id: user.id })

      if user.save
        render json: {
          id: user[:id],
          name: user[:name],
          email: user[:email],
          phone: user[:phone],
          document: user[:document],
          token: token
        }, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end

    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  def me
    render json: @current_user
  end

  def authenticate_motor_curier
    motor_curier = MotorCurier.find_by(code: params[:code])

    if motor_curier.nil?
      return render json: { message: "Motor curier not found" }, status: :not_found
    end

    token = JwtService.new.encode({ id: motor_curier[:id] })

    render json: {
      id: motor_curier[:id],
      name: motor_curier[:name],
      code: motor_curier[:code],
      token: token
    }
  end


  def login_params
    params.permit(:email, :password)
  end


  private
  def register_params
    params.permit(
    user: [ :email, :password, :name, :document, :phone ],
    company: [ :name, :document, :phone ],
    address: [ :address, :lat, :lng ]
    )
  end
end
