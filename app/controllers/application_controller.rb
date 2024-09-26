class ApplicationController < ActionController::API
  before_action :authorization

  def authorization
    auth = request.headers[:authorization]


    if auth.nil?
      return render json: { message: "unauthorized" }, status: :unauthorized
    end

    token = auth.split(" ")[1]

    if token.nil?
      return render json: { message: "unauthorized" }, status: :unauthorized
    end

    begin
      decoded = JwtService.new.decode(token).first

      if decoded.nil?
        return render json: { message: "unauthorized" }, status: :unauthorized
      end

      if decoded["type"] == "user"
        user = User.find(decoded["id"])
        if user.nil?
          return render json: { message: "unauthorized" }, status: :unauthorized
        end

        @current_user = {
          id: user[:id],
          email: user[:email],
          name: user[:name],
          type: "user"
        }
      end

      if decoded["type"] == "customer"
        customer = Customer.find(decoded["id"])
        if customer.nil?
          return render json: { message: "unauthorized" }, status: :unauthorized
        end

        @current_user = {
          id: customer[:id],
          email: customer[:email],
          name: customer[:name],
          type: "customer"
        }
      end

    rescue JWT::DecodeError
      render json: { message: "unauthorized" }, status: :unauthorized

    rescue
      render json: { message: "unauthorized" }, status: :unauthorized
    end
  end
end
