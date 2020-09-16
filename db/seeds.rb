# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Tagging.delete_all
Post.delete_all
Tag.delete_all
Category.delete_all

tag_js =Tag.create(name:"javascript")
tag_ruby=Tag.create(name:"ruby")
tag_react=Tag.create(name:"react")


cat_web = Category.create(name:"Web Development", description:"All about Web Development")
cat_prog = Category.create(name:"Programming", description:"All about Programming")

urvashi = User.create(
  email:"urvashi@gmail.com",
  password:"12345678",
  password_confirmation: "12345678"
)

admin = User.create(
  email:"admin@gmail.com",
  password:"12345678",
  password_confirmation: "12345678"
)

10.times do |i|
   Post.create(
    user: i % 2 == 0 ?urvashi : admin,
    title:"Post #{i}",
    body: "Post #{i} body goes here...",
    published:true,
    category: i % 2 == 0 ? cat_web: cat_prog,
    tags: i % 2 == 0 ? [tag_js,tag_ruby]: [tag_react]
  )
end
