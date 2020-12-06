class StaticPagesController < ApplicationController
  def top
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
    end
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
