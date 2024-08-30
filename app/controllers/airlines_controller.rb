class AirlinesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @airline = Airline.find(params[:id])
    @airlines = Airline.all
    @policies = Policy.where(airline_id: @airline)
    @cabin_policy = Policy.where(airline_id: @airline, category: "cabin baggage")
    @checked_policy = Policy.where(airline_id: @airline, category: "checked baggage")
    @special_policy = Policy.where(airline_id: @airline, category: "special baggage")
  end

  def search
    @airline = Airline.find_by(name: params[:query])
    if @airline
      redirect_to airline_path(@airline)
    else
      flash[:alert] = "Airline not found"
      redirect_to root_path
    end
  end

  def search_suggestions
    @airlines = Airline.where("name ILIKE ?", "%#{params[:query]}%")
    render json: @airlines.map { |airline| { id: airline.id, name: airline.name } }
  end
end
