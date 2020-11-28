class StaticPagesController < ApplicationController
  def top
    if logged_in?
      @live_items = current_user.live.paginate(page: params[:page], per_page: 5)
    end
  end

  def about
  end
end
