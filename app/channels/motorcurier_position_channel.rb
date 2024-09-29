class MotorcurierPositionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "motorcurier_position_#{params[:id]}"
  end
end
