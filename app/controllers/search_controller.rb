# Author: Mike
# Created: 7/19
# Description: Perform search for Book and Posts

class SearchController < ApplicationController

	# Author: Mike
	# Created: 7/19
	# Description: GET route for search with all conditions and filters
	def search

		# Prevent user input of large number
		if params[:low_price].length>15 || params[:low_price].to_i <0 || params[:low_price].to_i > 10000 then
		  	flash[:notice] = "Filter price must be in range $0 - $10,000"
		  	redirect_to search_path(search_for: params[:search_for], offer_request: params[:offer_request], edition: params[:edition], condition: params[:condition], low_price: 0, high_price: params[:high_price])
		  	return
		 elsif params[:high_price].length>15 || params[:high_price].to_i < 0 || params[:high_price].to_i > 10000 then
		  	flash[:notice] = "Filter price must be in range $0 - $10,000"
		  	redirect_to search_path(search_for: params[:search_for], offer_request: params[:offer_request], edition: params[:edition], condition: params[:condition], low_price: params[:low_price], high_price: 10000)
		  	return
		 end

		 # Perform book search first
		 books = book_search
		 # Then user the result from book search, refine result with posts
		 post_refine_search books.results
		 # Update edition options if params[:edition] is not 'all'
		 if params[:edition]!='all' then
		 	edition_update books.results
		 end
	end

	# Search titles/ISBN in the book
	def book_search
		Book.search do
			# Match title or ISBN
			fulltext params[:query] do
				if params[:search_for]=='Title' then
					fields(:title)
				elsif params[:search_for]=='ISBN' then
					fields(:ISBN_10, :ISBN_13)
				end
			end
		end
	end

	# Refine results to post_type, condition, edition, prices in Post
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

	    		# Match edition
				if params[:edition]!="all" then
					fulltext params[:edition] do
						fields(:edition)
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
	      		# Reject results if post status is closed, draft or deleted
	      		if post.status != "closed" && post.status != "draft" && post.status != "deleted" then
	      			@posts.append(post)
	      		end

	      		# Update condition options
	      		if params[:condition]=="all" then
		      		unless @conditions.include? post.condition then
		      			if post.condition!="Unacceptable"
		      				@conditions.append(post.condition)
		      			else
		      				@conditions.append(["Used - poor", post.condition])
		      			end
		      		end
		      	end

		      	# Update edition options
		      	if params[:edition]=="all" then
	    			unless @editions.include? post.edition then
		      			@editions.append(post.edition)
		      		end
		      	end
	    	end
	  	end

	  	# Define parameters
	  	@posts.uniq!
	  	@post_type = params[:offer_request]
	  	@search_for = params[:search_for]
	  	@search_field = params[:query]
	  	@condition = params[:condition]
	  	@edition = params[:edition]
	  	@msg = "Find "+@posts.length.to_s+" Posts in total"
	  	@low_price = params[:low_price]
	  	@high_price = params[:high_price]
	end

	# Update editions options if the user-choice edition is not "all"
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
	    		# Update edition
	    		if post.status!= "closed" && post.status != "draft" && post.status != "deleted" then
	    			unless @editions.include? post.edition then
		      			@editions.append(post.edition)
		      		end
		      	end
	    	end
	    end

	end
end
