class SearchController < ApplicationController

	def search
	  books = book_search params[:query], params[:edition]
	  post_refine_search books.results
	  if params[:edition]!='all' then
	  	books = book_search params[:query], 'all'
	  	edition_update books.results
	  end
	end

	def book_search query, edition
		Book.search do
			# Match title or ISBN
			fulltext query do
				if params[:search_for]=='Title' then
					fields(:title)
				elsif params[:search_for]=='ISBN' then
					fields(:ISBN_10, :ISBN_13)
				end
			end

			# Match edition
			if edition!="all" then
				fulltext edition+" th" do
					fields(:edition)
				end
			end
		end
	end

	def post_refine_search(books)
		@posts = []
		@editions = [['--edition--',:all]] if params[:edition]=="all"
		@conditions = [['--condition--',:all]] if params[:condition]=="all"
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
	      		if params[:condition]=="all" then
		      		unless @conditions.include? post.condition then
		      			if post.condition!="Unacceptable"
		      				@conditions.append(post.condition)
		      			else
		      				@conditions.append(["Used - poor", post.condition])
		      			end
		      		end
		      	end

		      	if params[:edition]=="all" then
		      		book = Book.find_by_id(post.book_id)
	    			unless @editions.include? book.edition then
		      			@editions.append(book.edition)
		      		end
		      	end
	    	end
	  	end

	  	@post_type = params[:offer_request]
	  	@search_for = params[:search_for]
	  	@search_field = params[:query]
	  	@condition = params[:condition]
	  	@edition = params[:edition]
	  	@msg = "Find "+@posts.length.to_s+" Posts"
	  	# @msg = params
	end

	def edition_update (books)
		@editions = [['--edition--',:all]]

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
	    	end.results.each do |post|
	    		book = Book.find_by_id(post.book_id)
	    		unless @editions.include? book.edition then
		      		@editions.append(book.edition)
		      	end
	    	end
	    end

	end
end
