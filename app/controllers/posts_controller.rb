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
  @book = @post.book
  @back_url=session[:my_previous_url]
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
    redirect_to new_user_session_path, notice: 'Please login first to sell a book'
  else
    @post = current_user.posts.build
    # @book = Book.new
    @book= @post.build_book
    @image = @post.images.build
  end
end

def new_request
  if current_user.is_a?(GuestUser)
    redirect_to new_user_session_path, notice: 'Please login first to request a book'
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
  if post_params[:book]
    response = RestClient::Request.execute(
      method: :get,
      url: post_params[:book]['self_link'],
      )
    response=JSON.parse(response)
    @book = Book.where(self_link: post_params[:book]['self_link']).first_or_create do |book|
      book.title=response['volumeInfo']['title']
      book.subtitle=response['volumeInfo']['subtitle']
      book.description=response['volumeInfo']['description']
      book.publisher=response['volumeInfo']['publisher']
      book.publication_date=response['volumeInfo']['publishedDate']
      if response['volumeInfo']['authors'] then book.author=response['volumeInfo']['authors'].join(', ') end
      if response['saleInfo']['listPrice'] then book.list_price=response['saleInfo']['listPrice']['amount'] end
    end
    puts @book
    # new_book={}
    # new_book['self_link']=post_params[:book]['self_link']
    if response['volumeInfo']['industryIdentifiers']
        response['volumeInfo']['industryIdentifiers'].each do |isbn_type|
          type=isbn_type['type']
          @book[type]=isbn_type['identifier']
        end
    end
    if response['volumeInfo']['imageLinks']
        if response['volumeInfo']['imageLinks']['thumbnail']
          @book['cover_image']=response['volumeInfo']['imageLinks']['thumbnail']
        elsif response['volumeInfo']['imageLinks']['smallThumbnail']
          @book['cover_image']=response['volumeInfo']['imageLinks']['smallThumbnail']
        end
    end
    if response['volumeInfo']['industryIdentifiers']
        response['volumeInfo']['industryIdentifiers'].each do |isbn_type|
          type=isbn_type['type']
          @book[type]=isbn_type['identifier']
        end
    end
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
                if post_params['post_type']=='offer'
                  format.html { render :new_offer }
                  format.json { render json: @order.errors, status: :unprocessable_entity }
                else
                  format.html { render :new_request }
                  format.json { render json: @order.errors, status: :unprocessable_entity }
                end
            end
          end
      end
  else
      if post_params['post_type']=="offer"
        redirect_to posts_new_offer_path, notice:"Need Book Information"
      else
        redirect_to posts_new_request_path, notice:"Need Book Information"
      end
  end
end

# PATCH/PUT /posts/1
# PATCH/PUT /posts/1.json
def update
  puts "post_params"
  puts post_params
  if post_params[:book]
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
          puts type
          puts isbn_type['identifier']
          @book[type]=isbn_type['identifier']
        end
    end
    @book['cover_image']=response['volumeInfo']['imageLinks']['thumbnail']
      if @book.save
      # @posts.book_id=@book.id
        @post = current_user.posts.new(post_params.merge({book: @book}))

          respond_to do |format|
            if @post.update(post_params)
                if params[:images]
                    params[:images]['actual_product_image'].each do |image|
                      @image = @post.images.create!(:actual_product_image => image)
                    end
                end
                format.html { redirect_to @post, notice: 'Post was successfully updated.' }
                format.json { render :show, status: :created, location: @post }
            else
                if post_params['post_type']=='offer'
                  format.html { render :edit_offer }
                  format.json { render json: @order.errors, status: :unprocessable_entity }
                else
                  format.html { render :edit_request }
                  format.json { render json: @order.errors, status: :unprocessable_entity }
                end
            end
          end
      end
  else
      if post_params['post_type']=="offer"
        redirect_to posts_new_offer_path, notice:"Need Book Information"
      else
        redirect_to posts_new_request_path, notice:"Need Book Information"
      end
  end
end

# DELETE /posts/1
# DELETE /posts/1.json
def destroy
  contracts=Contract.where(post: @post)
  contracts.each do |contract|
    orders=Order.where(contract: contract)
    orders.each do |order|
      order.delete
    end
    contract.delete
  end
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
