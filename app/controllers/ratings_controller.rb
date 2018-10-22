class RatingsController < ApplicationController
  def index
    @beers = Rails.cache.read("Beer-top-3")
    @breweries = Rails.cache.read("Brewery-top-3")
    @styles = Rails.cache.read("Style-top-3")
    @users = Rails.cache.read("User-top-3")
    @ratings = Rails.cache.read("Rating-recent-5")
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
