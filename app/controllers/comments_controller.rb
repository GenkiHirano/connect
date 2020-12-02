class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @live_companion = LiveCompanion.find(params[:live_companion_id])
    @user = @live_companion.user
    @comment = @live_companion.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@live_companion.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @live_companion = @comment.live_companion
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to live_companion_url(@live_companion)
  end
end
