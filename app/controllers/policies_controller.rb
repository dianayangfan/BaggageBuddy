class PoliciesController < ApplicationController

  # This is for testing purposes
  # def index
  #  @policies = Policy.all
  # end

  def show
    @policy = Policy.find(params[:id])
  end
end
