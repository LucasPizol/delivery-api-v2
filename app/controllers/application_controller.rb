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



      if decoded.present?
        @current_user = Customer.find(decoded["customer_id"])
        if @current_user.nil?
          render json: { message: "unauthorized" }, status: :unauthorized
        end
      end
    rescue JWT::DecodeError
      render json: { message: "unauthorized" }, status: :unauthorized

    rescue
      render json: { message: "unauthorized" }, status: :unauthorized
    end
  end
end
