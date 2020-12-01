class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @live_companion = LiveCompanion.find(params[:live_companion_id])
    @user = @live_companion.user
    current_user.favorite(@dish)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @live_companion = LiveCompanion.find(params[:live_companion_id])
    current_user.favorites.find_by(live_companion_id: @live_companion.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
