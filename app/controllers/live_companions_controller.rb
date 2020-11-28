class LiveCompanionsController < ApplicationController
  before_action :logged_in_user

  def new
    @live_companion = LiveCompanion.new
  end

  def create
    @live_companion = current_user.live_companions.build(live_companion_params)
    if @live_companion.save
      flash[:success] = "ライブ同行者の募集が完了しました！"
      redirect_to root_url
    else
      render 'live_companions/new'
    end
  end

  private

    def live_companion_params
      params.require(:live_companion).permit(:artist_name, :live_name, :live_memo)
    end
end
