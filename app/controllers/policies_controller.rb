class PoliciesController < ApplicationController

<<<<<<< HEAD
=======
  # This is for testing purposes
>>>>>>> master
  # def index
  #  @policies = Policy.all
  # end

  def show
    @policy = Policy.find(params[:id])
  end
end
