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

      begin
        @user = User.find(decoded["id"])
      rescue
        @user = MotorCurier.find(decoded["id"])
      end

      if @user.nil?
        return render json: { message: "unauthorized" }, status: :unauthorized
      end

      @current_user = {
        id: @user[:id],
        email: @user[:email],
        name: @user[:name],
        company_id: @user[:company_id],
        type: "user"
      }
    rescue JWT::DecodeError
      render json: { message: "asdas" }, status: :unauthorized

    rescue
      render json: { message: "sss" }, status: :unauthorized
    end
  end
end
