class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :toggle_status]
# GET /posts
# GET /posts.json
def index
  @posts = Post.all
  @page_title="My Post"
end

# GET /posts/1
# GET /posts/1.json
def show
  # @page_title=@post.title
end

# GET /posts/new
def new
  @post = Post.new
end

# GET /posts/1/edit
def edit
end

# POST /posts
# POST /posts.json
def create
  @post = Post.new(post_params)

  respond_to do |format|
    if @post.save
      format.html { redirect_to @post, notice: 'Post was successfully created.' }
      format.json { render :show, status: :created, location: @post }
    else
      format.html { render :new }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /posts/1
# PATCH/PUT /posts/1.json
def update
  respond_to do |format|
    if @post.update(post_params)
      format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      format.json { render :show, status: :ok, location: @post }
    else
      format.html { render :edit }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /posts/1
# DELETE /posts/1.json
def destroy
  @post.destroy
  respond_to do |format|
    format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    format.json { head :no_content }
  end
end

def toggle_status
  @post.draft?? @post.published! : @post.draft!
  redirect_to posts_url, notice: "post status changed"
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:course_number,:post_type,:price,:condition,:payment_method,:description,:status)
  end

  
end
