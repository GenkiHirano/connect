class LiveCompanionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def new
    @live_companion = LiveCompanion.new
  end

  def show
    @live_companion = LiveCompanion.find(params[:id])
    @comment = Comment.new
  end

  def index
    @log = Log.new
  end

  def create
    @live_companion = current_user.live_companions.build(live_companion_params)
    if @live_companion.save
      flash[:success] = "ライブ同行者の募集が完了しました！"
      redirect_to live_companion_path(@live_companion)
    else
      render 'live_companions/new'
    end
  end

  def edit
    @live_companion = LiveCompanion.find(params[:id])
  end

  def update
    @live_companion = LiveCompanion.find(params[:id])
    if @live_companion.update_attributes(live_companion_params)
      flash[:success] = "ライブ情報が更新されました！"
      redirect_to @live_companion
    else
      render 'edit'
    end
  end

  def destroy
    @live_companion = LiveCompanion.find(params[:id])
    if current_user.admin? || current_user?(@live_companion.user)
      @live_companion.destroy
      flash[:success] = "投稿が削除されました"
      redirect_to request.referrer == user_url(@live_companion.user) ? user_url(@live_companion.user) : root_url
    else
      flash[:danger] = "他人の投稿は削除できません"
      redirect_to root_url
    end
  end

  private

    def live_companion_params
      params.require(:live_companion).permit(:artist_name, :live_name, :live_memo, :schedule, :live_venue, :picture)
    end

    def correct_user
      @live_companion = current_user.live_companions.find_by(id: params[:id])
      redirect_to root_url if @live_companion.nil?
    end
end
