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
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.save!
}

10.times { |index|
  Book.create!(
    isbn10: "#{index + 1}",
    isbn13: "#{987654321 - index}",
    edition: "#{index} th",
    title: "hello #{index*2}",
    cover_image: "http://via.placeholder.com/120x150",
    amazon_price: index*5 + 22.5)
}

10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: index/2,
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 0,
    book_id: Book.find(index+1).id,
    user_id: User.find(index+1).id)
}

5.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,2,3,4,5,index+10),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 0,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,2,3,4+index,5,index+10),
    status: 0,
    seller_id: User.find(10-index).id,
    buyer_id: User.find(index+1).id,
    unsigned_user_id: User.find(index+1).id,
    post_id: Post.find(index+1).id)
}

5.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,2,3,4,5,index+10),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 1,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,2,3,4+index,5,index+10),
    status: 1,
    seller_id: User.find(index+1).id,
    buyer_id: User.find(10-index).id,
    unsigned_user_id: User.find(index+4).id,
    post_id: Post.find(10-index).id)
}

10.times { |index|
  Image.create!(
    actual_product_image: "http://via.placeholder.com/300x100",
    post_id: Post.find(index+1).id)
}

10.times { |index|
  Message.create!(
    content: "Hello, User #{11-index}",
    post_id: Post.find(index+1).id,
    sender_id: Post.find(index+1).user_id,
    receiver_id: User.find(10-index).id)
}

3.times { |index|
  Order.create!(
    status: 0,
    contract_id: Contract.find(index+1).id)
}

3.times { |index|
  Order.create!(
    status: 1,
    contract_id: Contract.find(index+3).id)
}

4.times { |index|
  Order.create!(
    status: 2,
    contract_id: Contract.find(index+6).id)
}
