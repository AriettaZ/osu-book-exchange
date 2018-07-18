# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 10.times { |index|
#   User.create!(
#     email: "user.#{index+1}@osu.edu",
#     encrypted_password: "$2a$11$0W2FjxG8w/rDCcKdaFTK9u677pukARVBo2f3oKVtNIQwRg6QD4ge2",
#     major: "CSE",
#     phone: "8888888888",
#     reset_password_token: "reset",
#     reset_password_sent_at: DateTime.new(2018,2,3,4,5,index+10),
#     remember_created_at: DateTime.new(2017,2,3,8,5,index+10),
#     sign_in_count: 5,
#     current_sign_in_at: DateTime.new(2018,2,3,4,5,index+10),
#     last_sign_in_at: DateTime.new(2018,1,3,4,5,index+10),
#     current_sign_in_ip: "128.146.165.224",
#     last_sign_in_ip: "128.146.165.224")
# }

10.times { |index|
  Book.create!(
    isbn10: "#{index + 1}",
    isbn13: "#{987654321 - index}",
    edition: "#{index} th",
    title: "hello #{index*2}",
    cover_image: "hello",
    amazon_price: index*5 + 22.5)
}

10.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: index+100,
    condition: "new",
    payment_method: 0,
    description: "a brand new book #{index}",
    status: 0,
    book_id: Book.find(index+1),
    user_id: User.find(index+1))
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
    seller_id: User.find(10-index),
    buyer_id: User.find(index),
    unsigned_user_id: User.find(index+2),
    post_id: Post.find(index+1))
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
    seller_id: User.find(index).id,
    buyer_id: User.find(10-index).id,
    unsigned_user_id: User.find(index+4).id,
    post_id: Post.find(10-index).id)
}

10.times { |index|
  Image.create!(
    actual_product_image: "Image #{index+1}",
    post_id: Post.find(index+1).id)
}

10.times { |index|
  Message.create!(
    content: "Hello, User #{10-index}",
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
