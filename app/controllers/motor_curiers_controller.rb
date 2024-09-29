class MotorCuriersController < ApplicationController
  before_action :set_motor_curier, only: %i[ show destroy ]

  # GET /motor_curiers
  def index
    @motor_curiers = MotorCurier.where(company_id: @current_user[:company_id])

    render json: @motor_curiers
  end

  # GET /motor_curiers/1
  def show
    render json: @motor_curier
  end

  # POST /motor_curiers
  def create
    copied_params = motor_curier_params.dup

    copied_params[:company_id] = @current_user[:company_id]
    copied_params[:code] = SecureRandom.hex(3).upcase

    @motor_curier = MotorCurier.new(copied_params)

    if @motor_curier.save
      render json: @motor_curier, status: :created, location: @motor_curier
    else
      render json: @motor_curier.errors, status: :unprocessable_entity
    end
  end

  def update_location
    motor_curier = MotorCurier.find(
      @current_user[:id]
    )

    puts motor_curier_location_params

    if motor_curier.nil?
      return render json: { message: "Motor curier not found" }, status: :not_found
    end

    motor_curier.update(lat: motor_curier_location_params[:lat], lng: motor_curier_location_params[:lng])

    ActionCable.server.broadcast("motorcurier_position_#{motor_curier[:company_id]}", motor_curier)


    render json: motor_curier
  end

  # PATCH/PUT /motor_curiers/1
  def update
    if @motor_curier.update(motor_curier_params)
      render json: @motor_curier
    else
      render json: @motor_curier.errors, status: :unprocessable_entity
    end
  end

  # DELETE /motor_curiers/1
  def destroy
    @motor_curier.destroy!
  end

  private
    def motor_curier_params
      params.require(:motor_curier).permit(:name)
    end

    def motor_curier_location_params
      params.require(:motor_curier).permit(:lat, :lng)
    end
end
