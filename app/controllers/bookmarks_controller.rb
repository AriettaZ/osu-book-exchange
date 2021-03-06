# Created by Channing Jacobs
class BookmarksController < ApplicationController
  before_action :authenticate_user!
  # Create a new, unique bookmark for a post
  def create
    @bookmark = Bookmark.new(user_id: current_user.id,
    post_id: params[:post_id], :favorite => false)
    if @bookmark.save
      @posts = Post.all
      flash[:success] = "Bookmark Created"
    else
      flash[:failure] = "Already Bookmarked"
    end
    redirect_to post_url(params[:post_id])
  end
  # Remove the bookmark
  def destroy
    Bookmark.where(user_id: current_user.id, post_id: params[:post_id]).first.destroy
    flash[:success] = "Bookmark Destroyed"
    redirect_to profile_bookmarks_url
  end
  # Update the favorite status
  def edit
    bookmark = Bookmark.where(user_id: current_user.id, id: params[:bookmark_id]).first
    bookmark.favorite = !bookmark.favorite
    bookmark.save
    render profile_bookmarks_path
  end

end
