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

Friendship.create!(:user_id => 0, :friend_id  => 1)
Friendship.create!(:user_id => 0, :friend_id  => 2)
Friendship.create!(:user_id => 2, :friend_id  => 3)

Chatroom.create!(:id => 1, :name => 'first chat room')

ChatroomUser.create!(:chatroom_id => 1, :user_id => 0)
ChatroomUser.create!(:chatroom_id => 1, :user_id => 1)

Message.create!(:user_id => 0, :chatroom_id => 1, :content => "Hello there, I'm A", :status => 'Read')
Message.create!(:user_id => 1, :chatroom_id => 1, :content => "Hi there, I'm B", :status => 'Read')
Message.create!(:user_id => 0, :chatroom_id => 1, :content => "You are the first friend that I get in my address", :status => 'Unread')
Message.create!(:user_id => 0, :chatroom_id => 1, :content => "How are you", :status => 'Unread')