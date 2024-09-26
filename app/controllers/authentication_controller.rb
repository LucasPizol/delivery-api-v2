require "./app/services/jwt_service.rb"

class AuthenticationController < ApplicationController
  skip_before_action :authorization, only: [ :login, :register_user, :register_customer ]

  def login
    auth_type = nil

    if login_params[:type] == "user"
      auth_type = User.find_by(email: login_params[:email])
    elsif login_params[:type] == "customer"
      auth_type = Customer.find_by(email: login_params[:email])
    end

    if auth_type.nil?
      return render json: { message: "Email or password is incorrect" }, status: :unauthorized
    end

    begin
      if auth_type.authenticate(login_params[:password])
        token = JwtService.new.encode({ id: auth_type[:id], type: login_params[:type] })

        render json: {
          id: auth_type[:id],
          name: auth_type[:name],
          email: auth_type[:email],
          phone: auth_type[:phone],
          document: auth_type[:document],
          type: login_params[:type],
          token: token
        }, status: :ok
      end

    rescue JWT::EncodeError
      render json: { message: "Email or password is incorrect" }, status: :unauthorized

    end
  end

  def register_user
    user = User.new(register_user_params[:user])
    company = Company.new(register_user_params[:company])
    address = Address.new(register_user_params[:address])
    user.company = company
    company.address = address

    if company.save
      token = JwtService.new.encode({ id: user[:id], type: "user" })

      if user.save
        render json: {
          user: user,
          token: token
        }, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end

    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  def register_customer
    customer = Customer.new(register_customer_params[:customer])
    address = Address.new(register_customer_params[:address])

    customer.address = address

    if customer.save
      token = JwtService.new.encode({ id: customer[:id], type: "customer" })

      render json: {
        customer: customer,
        token: token
      }, status: :created
    else
      render json: customer.errors, status: :unprocessable_entity
    end
  end

  def me
    render json: @current_user
  end


  def login_params
    params.permit(:email, :password, :type)
  end

  private
  def register_user_params
    params.permit(
    user: [ :email, :password, :name, :document, :phone ],
    company: [ :name, :document, :phone ],
    address: [ :street, :number, :complement, :district, :city, :state, :country, :zipcode ]
    )
  end

  def register_customer_params
    params.permit(
      customer: [ :email, :password, :name, :document, :phone ],
      address: [ :street, :number, :complement, :district, :city, :state, :country, :zipcode ]
    )
  end
end
