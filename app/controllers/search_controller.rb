class SearchController < ApplicationController

	def search
	  # books = Book.search{fulltext params[:query]}.results
	  # # @msg=[]
	  # # @posts = Post.search{fulltext params[:query] }.results
	  # @posts = []
	  # books.each do
	  #   |book| 
	  #   Post.search{fulltext book.id do fields(:book_id) end}.results.each do
	  #     |post|
	  #     @posts.append(post)
	  #   end
	  # end
	  # # @msg = "This is message: "+params[:query]
	  # # @msg = "Book Title: "
	  # @page_title="My Search Posts"

	  books = book_search
	  post_refine_search books.results


	end

	def book_search
		Book.search do 
			# Match title or ISBN
			fulltext params[:query] do 
				if params[:search_for]=='Title' then
					fields(:title) 
				elsif params[:search_for]=='ISBN' then
					fields(:isbn10, :isbn13)
				end
			end

			# Match edition
			if(params[:edition]!="all") then
				fulltext params[:edition]+" th" do
					fields(:edition) 
				end
			end
		end
	end


	def post_refine_search(books)
		@posts = []
		books.each do
	    	|book| 
	    	Post.search do 
	    		# Match Book id
	    		fulltext book.id do 
	    			fields(:book_id) 
	    		end

	    		# Match post_type (offer or request)
	    		if(params[:offer_request]!="both") then
	    			fulltext params[:offer_request] do 
	    				fields(:post_type)
	    			end
	    		end

	    		# Match book condition
	    		if(params[:condition]!="all") then
	    			fulltext params[:condition] do
	    				fields(:condition)
	    			end
	    		end

	    		# Match book max/min price
	    		if(params[:low_price]!="") then
	    			with(:price).greater_than(params[:low_price].to_f-1)
	    		end
	    		if(params[:high_price]!="") then
	    			with(:price).less_than(params[:high_price].to_f+1)
	    		end
	    	end.results.each do
	      		|post|
	      		@posts.append(post)
	    	end
	  	end

	  	@msg = "Find "+@posts.length.to_s+" Posts"
	end

end
