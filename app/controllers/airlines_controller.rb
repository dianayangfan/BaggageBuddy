class AirlinesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @airline = Airline.find(params[:id])
    @policies = Policy.where(airline_id: @airline)
  end
end
