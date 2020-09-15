# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tagging.delete_all
Post.delete_all
Tag.delete_all
Category.delete_all

Tag.create(name:"javascript")
Tag.create(name:"ruby")
Tag.create(name:"react")


cat_web = Category.create(name:"Web Development", description:"All about Web Development")
cat_prog = Category.create(name:"Programming", description:"All about Programming")

10.times do |i|
   Post.create(
    title:"Post #{i}",
    body: "Post #{i} body goes here...",
    category: i % 2 == 0 ? cat_web: cat_prog
  )
end
