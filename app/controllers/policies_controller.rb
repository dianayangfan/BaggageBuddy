class PoliciesController < ApplicationController

  def show
    @policy = Policy.find(params[:id])
  end
end
