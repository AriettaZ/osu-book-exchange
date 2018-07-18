# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times { |index|
  Post.create(post_type: 0, course_number: "cse3901", price: index+100, condition: "new", payment_method: 0, description: "a brand new book", status: 0)
}

5.times { |index|
  Book.create(isbn10: "#{index + 1}", isbn13: "#{987654321 - index}", edition: "#{index} th", title: "hello #{index*2}", cover_image: "hello", amazon_price: index + 22.5)
}
