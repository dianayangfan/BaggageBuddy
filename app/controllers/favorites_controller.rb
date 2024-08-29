class FavoritesController < ApplicationController
  before_action :set_user, only: [:create, :destroy]


  # before_action :set_airline, only: %i[new create]
  # before_action :set_favorite, only: %i[destroy]
  # before_action :set_policy, only: %i[new create]
  # before_action :set_airline, only: %i[new create]
  # before_action :authenticate_user!


  def create
    @policy = Policy.find(params[:policy_id])
    @favorite = Favorite.new
    @favorite.policy = @policy
    @favorite.user = @user

    if @favorite.save
      flash[:notice] = "Policy has been added to your favorites."
      redirect_to airline_policy_path(@policy.airline, @policy)
    else
      flash[:alert] = "Unable to add policy to favorites."
      redirect_to airline_policy_path(@policy.airline, @policy), status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_profile_path, status: :see_other
  end

  private

  def favorite_params
    params.require(:favorite).permit(:policy_id)
  end

  def set_user
    @user = current_user
  end
end
