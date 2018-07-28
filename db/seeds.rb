# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times { |index|
  user = User.new
  user.email = "user.#{index+1}@osu.edu"
  user.major= "CSE"
  user.name = "Brutus #{index+1}"
  user.phone= "8888888888"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role=:user
  user.save!
}

1.times { |index|
  user = User.new
  user.email = "zhu.1444@osu.edu"
  user.major= "CSE"
  user.name = "Ariel Zhu"
  user.phone= "8888888888"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role=:site_admin
  user.save!
}
1.times { |index|
  user = User.new
  user.email = "jacobs.951@osu.edu"
  user.major= "CSE"
  user.name = "Channing Jacobs"
  user.phone= "8888888888"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role=:site_admin
  user.save!
}
1.times { |index|
  user = User.new
  user.email = "lin.2453@osu.edu"
  user.major= "CSE"
  user.name = "Mike Lin"
  user.phone= "8888888888"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role=:site_admin
  user.save!
}
1.times { |index|
  user = User.new
  user.email = "chen.6627@osu.edu"
  user.major= "CSE"
  user.name = "Gail Chen"
  user.phone= "8888888888"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role=:site_admin
  user.save!
}

1.times { |index|
  user = User.new
  user.email = "admin@osu.edu"
  user.major= "CSE"
  user.name = "ADMIN"
  user.phone= "8888888888"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role=:site_admin
  user.save!
}

1.times { |index|
  user = User.new
  user.email = "test@osu.edu"
  user.major= "CSE"
  user.name = "TEST"
  user.phone= "8888888888"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role=:user
  user.save!
}

development_response = RestClient::Request.execute(
  method: :get,
  url: "https://www.googleapis.com/books/v1/volumes?q=development",
  )
computer_response= RestClient::Request.execute(
  method: :get,
  url: "https://www.googleapis.com/books/v1/volumes?q=computer",
  )
ruby_response= RestClient::Request.execute(
  method: :get,
  url: "https://www.googleapis.com/books/v1/volumes?q=ruby",
  )
python_response= RestClient::Request.execute(
  method: :get,
  url: "https://www.googleapis.com/books/v1/volumes?q=python",
)
ohio_response= RestClient::Request.execute(
  method: :get,
  url: "https://www.googleapis.com/books/v1/volumes?q=ohio",
)
teamwork_response= RestClient::Request.execute(
  method: :get,
  url: "https://www.googleapis.com/books/v1/volumes?q=teamwork",
)
responses=JSON.parse(development_response)['items']
responses+=JSON.parse(computer_response)['items']
responses+=JSON.parse(ruby_response)['items']
responses+=JSON.parse(python_response)['items']
responses+=JSON.parse(ohio_response)['items']
responses+=JSON.parse(teamwork_response)['items']
puts responses
responses.each do |response|
  @book = Book.where(self_link: response['selfLink']).first_or_create do |book|
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
  @book.save
end



2.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: 20,
    condition: 3,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+1).id,
    user_id: User.find_by(email: "chen.6627@osu.edu").id)
}

2.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: 30,
    condition: 4,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+1).id,
    user_id: User.find_by(email: "test@test").id)
}

2.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: 100,
    condition: 2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+1).id,
    user_id: User.find_by(email: "jacobs.951@osu.edu").id)
}


2.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: 100,
    condition: 3,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+1).id,
    user_id: User.find_by(email: "lin.2453@osu.edu").id)
}
2.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: 13,
    condition: 4,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+1).id,
    user_id: User.find_by(email: "zhu.1444@osu.edu").id)
}
10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+1).id,
    user_id: User.find(index+1).id)
}
10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+21).id,
    user_id: User.find(index+1).id)
}
10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+11).id,
    user_id: User.find(index+1).id)
}
10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+31).id,
    user_id: User.find(index+1).id)
}
10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+41).id,
    user_id: User.find(index+1).id)
}
10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+51).id,
    user_id: User.find(index+1).id)
  }

10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+30).id,
    user_id: User.find(email: "admin@osu.edu").id)
}
10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 1,
    book_id: Book.find(index+40).id,
    user_id: User.find(email: "test@osu.edu").id)
}
5.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,9,28,4,5),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 0,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,9,28,4+index,5),
    status: 0,
    seller_id: Post.find(index+1).user_id,
    buyer_id: User.find(index+1).id,
    unsigned_user_id: User.find(index+1).id,
    post_id: Post.find(index+1).id)
    post = Post.find(index+1)
    post.status = 2
    post.save
}

10.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,10,23,4,5),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 1,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,10,13,4+index,5),
    status: 1,
    seller_id: Post.find(index+1).user_id,
    buyer_id: User.find(index+1).id,
    unsigned_user_id: nil,
    post_id: Post.find(index+1).id)
  Order.create!(
      status: 0,
      contract_id: Contract.find(index+1).id)
  post = Post.find(Post.find(index+1).id)
  post.status = 3
  post.save
}

10.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,10,23,4,5),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 1,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,10,13,4+index,5),
    status: 2,
    seller_id: Post.find_by(email:"admin@osu.edu").user_id,
    buyer_id: User.find(index+11).id,
    unsigned_user_id: nil,
    post_id: Post.find(index+11).id)
  Order.create!(
      status: 0,
      contract_id: Contract.find(index+11).id)
  post = Post.find(Post.find(index+11).id)
  post.status = 3
  post.save
}

10.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,10,23,4,5),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 1,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,10,13,4+index,5),
    status: 3,
    seller_id: Post.find_by(index+21).user_id,
    buyer_id: User.find(index+1).id,
    unsigned_user_id: nil,
    post_id: Post.find(index+21).id)
  Order.create!(
      status: 0,
      contract_id: Contract.find(index+21).id)
  post = Post.find(Post.find(index+31).id)
  post.status = 3
  post.save
}

image_data= File.open(File.join(Rails.root, "/app/assets/images/magic_logo.jpg"))
10.times { |index|
  Image.create!(
    actual_product_image: image_data,
    post_id: Post.find(index+1).id)
}

10.times { |index|
  Image.create!(
    actual_product_image: image_data,
    post_id: Post.find(index+1).id)
}

14.times { |index|
  Image.create!(
    actual_product_image: image_data,
    post_id: Post.find_by(user_id:"#{1+index}").id)
}

10.times { |index|
  Message.create!(
    content: "Hello, User #{11-index}",
    post_id: Post.find(index+1).id,
    sender_id: Post.find(index+1).user_id,
    receiver_id: User.find(10-index).id)
}

10.times { |index|
  if index < 5
    Bookmark.create!(
      user_id: User.find_by(name: "Channing Jacobs").id,
      post_id: Post.find(index+1).id,
      favorite: true
    )
  else
    Bookmark.create!(
      user_id: User.find_by(email:"zhu.1444@osu.edu").id,
      post_id: Post.find(index+1).id,
      favorite: false
    )
  end
}
