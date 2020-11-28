class LiveCompanionsController < ApplicationController
  before_action :logged_in_user

  def new
    @live_companion = LiveCompanion.new
  end
end
