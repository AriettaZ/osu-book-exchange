# Created by Ariel
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :edit_offer, :edit_request, :update,:soft_delete, :destroy, :toggle_status]
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


def soft_delete
  @post.status='deleted'
  if @post.save
    flash[:notice] = "The post is deleted successfully"
  else
    flash[:notice] = "Error deleting post"
  end
  redirect_to @post
end
# GET /posts/1/seller_edit
def edit_offer
  @book = @post.book
end
# GET /posts/1/seller_edit
def edit_request
  @book = @post.book
end

# GET /posts/1/seller_edit
def edit
  @book = @post.book
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
    if response['volumeInfo']['industryIdentifiers']
        response['volumeInfo']['industryIdentifiers'].each do |isbn_type|
          if isbn_type['type']=='ISBN_13'
            @book['ISBN_13']=isbn_type['identifier']
          elsif isbn_type['type']=='ISBN_10'
            @book['ISBN_10']=isbn_type['identifier']
          end
        end
    end
    if response['volumeInfo']['imageLinks']
        if response['volumeInfo']['imageLinks']['thumbnail']
          @book['cover_image']=response['volumeInfo']['imageLinks']['thumbnail']
        elsif response['volumeInfo']['imageLinks']['smallThumbnail']
          @book['cover_image']=response['volumeInfo']['imageLinks']['smallThumbnail']
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
          format.html { render :edit_offer}
          format.json { render json: @order.errors, status: :unprocessable_entity }
        else
          format.html { render :edit_request }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
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
    format.html { redirect_to root_url, notice: 'Post was successfully destroyed.' }
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
    params.require(:post).permit(:course_number,:post_type,:price,:edition,:condition,:payment_method,:description,:status,images_attributes: [:id, :post_id, :actual_product_image],:book=> [:id, :self_link])
  end


end
