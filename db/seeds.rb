# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Message.delete_all
User.delete_all
ChatroomUser.delete_all
Chatroom.delete_all
Friendship.delete_all
%w{albert bella carlos david edgar fun gerard henry}.each_with_index do |name, index|
	User.create!(:id => index, :name => name, :email => "#{name}@email", :password => name)
end

# Friendship.create!(:user_id => 0, :friend_id  => 1)
# Friendship.create!(:user_id => 0, :friend_id  => 2)
# Friendship.create!(:user_id => 2, :friend_id  => 3)
User.find(0).make_friend_with(1)
User.find(0).make_friend_with(2)
User.find(0).make_friend_with(3)
User.find(0).make_friend_with(4)
User.find(0).make_friend_with(5)
User.find(0).make_friend_with(6)
User.find(2).make_friend_with(3)


a = User.first
e = User.find(4)
f = User.find(5)

a.send_message_to("Hello edgar, fun", ["4","5"])
e.send_message_to("Hello albert, fun", ["0","5"])