class PlacesController < ApplicationController
  def index
  end

  def show
    @place = Rails.cache.read(session[:last_search])
                  .find{ |p| p.id == params[:id].to_s }
  end

  def search
    @places = BeerMappingAPI.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}."
    else
      session[:last_search] = params[:city]
      render :index
    end
  end
end
