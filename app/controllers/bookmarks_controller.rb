class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = Bookmark.new(user_id: current_user.id,
    post_id: params[:post_id], :favorite => false)
    if @bookmark.save
      @posts = Post.all
      flash[:success] = "Bookmark Created"
      redirect_to "/posts/#{params[:post_id]}"
    else
      flash[:failure] = @bookmark.errors.full_messages
      redirect_to dashboard_main_url
    end
  end

  def destroy
    Bookmark.where(user_id: current_user.id, post_id: params[:post_id]).first.destroy
    flash[:success] = "Bookmark Destroyed"
    redirect_to dashboard_bookmarks_url
  end
end
