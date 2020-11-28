class StaticPagesController < ApplicationController
  def top
    @live = current_user.live.paginate(page: params[:page], per_page: 5)
  end

  def about
  end
end
