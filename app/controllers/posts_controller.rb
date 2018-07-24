class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :edit_offer, :edit_request, :update, :destroy, :toggle_status]
  access all: [:show,:new_offer,:new_request,:index], user: :all, site_admin: :all
# GET /posts
# GET /posts.json
def index
  # @posts = Post.all
  @posts=Post.where(status:[1,2])
  @page_title="My Post"
end
def admin_index
  @posts = Post.all
end

# GET /posts/1
# GET /posts/1.json
def show
  # @page_title=@post.title
  @images = @post.images.all
end

def new
  @post = current_user.posts.build
  # @book = Book.new
  @book= @post.build_book
  @image = @post.images.build
end

# GET /posts/new
def new_offer
  if current_user.is_a?(GuestUser)
    redirect_to new_user_session_path, notice: 'Please Login First'
  else
    @post = current_user.posts.build
    # @book = Book.new
    @book= @post.build_book
    @image = @post.images.build
  end
end

def new_request
  if current_user.is_a?(GuestUser)
    redirect_to new_user_session_path, notice: 'Please Login First'
  else
    @post = current_user.posts.build
    # @book = Book.new
    @book= @post.build_book
  end
end

# GET /posts/1/seller_edit
def edit_offer
end
# GET /posts/1/seller_edit
def edit_request
end

# GET /posts/1/seller_edit
def edit
end

# POST /posts
# POST /posts.json
def create
  puts "post_params"
  puts post_params
  puts params[:images]
  puts post_params[:book]['self_link']
  @book = Book.where(self_link: post_params[:book]['self_link']).first_or_create
  # puts @book.id
  # new_book={}
  # new_book['self_link']=post_params[:book]['self_link']
  response = RestClient::Request.execute(
    method: :get,
    url: post_params[:book]['self_link'],
    )
  response=JSON.parse(response)
  @book['title']=response['volumeInfo']['title']
  if response['volumeInfo']['industryIdentifiers']
    response['volumeInfo']['industryIdentifiers'].each do |isbn_type|
      type=isbn_type['type']
      @book[type]=isbn_type['type']['identifier']
    end
  end
  @book['cover_image']=response['volumeInfo']['imageLinks']['thumbnail']
  if @book.save
  # @posts.book_id=@book.id
    @post = current_user.posts.new(post_params.merge({book: @book}))

    respond_to do |format|
      if @post.save
        if params[:images]
          params[:images]['actual_product_image'].each do |image|
            @image = @post.images.create!(:actual_product_image => image)
          end
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
  contract=Contract.where(post:@post)
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
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:course_number,:post_type,:price,:condition,:payment_method,:description,:status,images_attributes: [:id, :post_id, :actual_product_image],:book=> [:id, :self_link])
  end


end
