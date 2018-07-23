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
  user.role=:user
  user.save!
}

1.times { |index|
  user = User.new
  user.email = "zhu.1444@osu.edu"
  user.major= "CSE"
  user.name = "Ariel Zhu"
  user.phone= "8888888888"
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.role=:site_admin
  user.save!
}
1.times { |index|
  user = User.new
  user.email = "jacobs.951@osu.edu"
  user.major= "CSE"
  user.name = "Channing Jacobs"
  user.phone= "8888888888"
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.role=:site_admin
  user.save!
}
1.times { |index|
  user = User.new
  user.email = "lin.2453@osu.edu"
  user.major= "CSE"
  user.name = "Mike Lin"
  user.phone= "8888888888"
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.role=:site_admin
  user.save!
}
1.times { |index|
  user = User.new
  user.email = "chen.6627@osu.edu"
  user.major= "CSE"
  user.name = "Gail Chen"
  user.phone= "8888888888"
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.role=:site_admin
  user.save!
}

1.times { |index|
  user = User.new
  user.email = "test@test"
  user.major= "CSE"
  user.name = "TEST"
  user.phone= "8888888888"
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.role=:user
  user.save!
}

10.times { |index|
  Book.create!(
    ISBN_10: "#{index + 1}",
    ISBN_13: "#{987654321 - index}",
    edition: "#{index} th",
    title: "hello #{index*2}",
    cover_image: "http://via.placeholder.com/120x150",
    amazon_price: index*5 + 22.5)
}


2.times { |index|
  Post.create!(
    post_type: 0,
    course_number: "cse3901",
    price: 100,
    condition: 0,
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
    price: 100,
    condition: 0,
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
    condition: 0,
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
    condition: 0,
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
    price: 100,
    condition: 0,
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

5.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,2,3,4,5),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 0,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,2,3,4+index,5),
    status: 0,
    seller_id: User.find(10-index).id,
    buyer_id: User.find(index+1).id,
    unsigned_user_id: User.find(index+1).id,
    post_id: Post.find(index+1).id)
}

3.times { |index|
  Contract.create!(
    meeting_time: DateTime.new(2018,2,3,4,5),
    meeting_address_first: "address#{index}",
    meeting_address_second: "address#{index+100}",
    final_payment_method: 1,
    final_price: "#{index+200.1}",
    expiration_time: DateTime.new(2018,2,3,4+index,5),
    status: 1,
    seller_id: User.find(index+1).id,
    buyer_id: User.find(10-index).id,
    unsigned_user_id: nil,
    post_id: Post.find(10-index).id)
  Order.create!(
      status: 0,
      contract_id: Contract.find(index+6).id)
}

image_data= File.open(File.join(Rails.root, "/app/assets/images/6631528842598_.pic.jpg"))
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
      post_id: Post.first.id,
      favorite: true
    )
  else
    # Bookmark.create!(
    #   user_id: User.find_by(name: Channing Jacobs),
    #   post_id: Post.first,
    #   favorite: false
    # )
  end
}
