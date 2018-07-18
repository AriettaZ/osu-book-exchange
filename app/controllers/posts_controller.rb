class PostsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]
layout "blog"
# GET /posts
# GET /posts.json
def index
  @posts = Post.all
  @page_title="My Portflio Post"
end

# GET /posts/1
# GET /posts/1.json
def show
  @page_title=@blog.title
end

# GET /posts/new
def new
  @blog = Post.new
end

# GET /posts/1/edit
def edit
end

# POST /posts
# POST /posts.json
def create
  @blog = Post.new(blog_params)

  respond_to do |format|
    if @blog.save
      format.html { redirect_to @blog, notice: 'Post was successfully created.' }
      format.json { render :show, status: :created, location: @blog }
    else
      format.html { render :new }
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /posts/1
# PATCH/PUT /posts/1.json
def update
  respond_to do |format|
    if @blog.update(blog_params)
      format.html { redirect_to @blog, notice: 'Post was successfully updated.' }
      format.json { render :show, status: :ok, location: @blog }
    else
      format.html { render :edit }
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /posts/1
# DELETE /posts/1.json
def destroy
  @blog.destroy
  respond_to do |format|
    format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    format.json { head :no_content }
  end
end

def toggle_status
  @blog.draft?? @blog.published! : @blog.draft!
  redirect_to posts_url, notice: "post status changed"
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Post.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(:title, :body)
  end
end
