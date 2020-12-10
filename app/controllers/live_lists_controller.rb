class LiveListsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def create
    @live_companion = LiveCompanion.find(params[:live_companion_id])
    @user = @live_companion.user
    current_user.live_list(@live_companion)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    live_list = LiveList.find(params[:live_list_id])
    @live_companion = live_list.live_companion
    live_list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
