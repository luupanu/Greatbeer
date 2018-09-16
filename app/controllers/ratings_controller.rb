class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    #raise
    if Beer.find_by_id params[:rating][:beer_id] then
      Rating.create params.require(:rating).permit(:score, :beer_id)
    else
      puts "beer not found!"
    end
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end