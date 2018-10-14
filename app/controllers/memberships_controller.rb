class MembershipsController < ApplicationController
  def new
    already_member_of = current_user.memberships.map(&:beer_club_id)
    @beer_clubs = BeerClub.all.where.not id: already_member_of
    @membership = Membership.new
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @membership.user = current_user

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership.beer_club, notice: "#{current_user.username} welcome to the club!" }
        format.json { render :show, status: :created, location: @membership }
      else
        @beer_clubs = BeerClub.all
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: "Membership in #{@membership.beer_club.name} ended." }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end
