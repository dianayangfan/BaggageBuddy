class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @airlines = Airline.all
    if params[:search].present?
      search_airlines
    end
  end

  def search_airlines
    if @airline == Airline.all.find{ |airline| airline.name.include?(params[:query]) }
      redirect_to airline_path(@airline)
    end
  end
end
