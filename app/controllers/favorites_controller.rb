class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @live_companion = LiveCompanion.find(params[:live_companion_id])
    @user = @live_companion.user
    current_user.favorite(@live_companion)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
    if @user != current_user
      @user.notifications.create(live_companion_id: @live_companion.id, variety: 1,
                                 from_user_id: current_user.id)
      @user.update_attribute(:notification, true)
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

  def index
    @favorites = current_user.favorites
  end
end
