class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]
    access user: [:show,:index, :new, :create, :update], site_admin: :all

   def search
     ## make your API Call on this action
     # base_url="https://www.googleapis.com/books/v1/volumes?"
     # response = HTTParty.get(base_url, :body => {:q => @keyword.gsub(" ","%20")}).to_json
     # @response_hash = JSON.parse(response)
     render :layout => false
   end

    # GET /books
    # GET /books.json
    def index
      @books = Book.all
    end

    # GET /books/1
    # GET /books/1.json
    def show
    end

    # GET /books/new
    def new
      @book = Book.new
    end

    # GET /books/1/edit
    def edit
    end

    # POST /books
    # POST /books.json
    def create
      puts book_params
      # if !(Book.find_by_ISBN_13(book_params['ISBN_13']) || Book.find_by_ISBN_13(book_params['ISBN_10']))
      @book = Book.new(book_params)
      # end
      respond_to do |format|
        if @book.save
          format.html {redirect_back fallback_location: new_post_url, locals: {selected_book: @book} }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { redirect_back fallback_location: new_post_url, locals: {selected_book: @book} }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    rescue ActionController::ParameterMissing
      redirect_back fallback_location: new_post_url, flash: { alert: "Please attach an image." }
    end

    # PATCH/PUT /books/1
    # PATCH/PUT /books/1.json
    def update
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /books/1
    # DELETE /books/1.json
    def destroy
      @book.posts.each do |post|
        post.contracts do |contract|
          contract.orders do |order|
            order.delete
          end
          constract.delete
        end
        post.delete
      end
      @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def book_params
        params.require(:book).permit(:ISBN_10,:ISBN_13,:description, :author, :publisher, :list_price,:publication_date, :subtitle, :edition,:title,:cover_image,:self_link)

      end

end
