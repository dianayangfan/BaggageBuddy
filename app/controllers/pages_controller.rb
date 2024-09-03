class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @airlines = Airline.all
  end

  def about
  end
end
