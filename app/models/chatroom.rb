class Chatroom < ApplicationRecord
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages

  def self.find_or_create_room(user_id, friend_id)
  	if @room = self.find_room(user_id, friend_id) then
  		return @room
  	else
  		# Create new room
  		@room = Chatroom.new(name: "[#{user_id}, #{friend_id}]")
  		@room.save if @room.valid?  		
  		@cru = ChatroomUser.create!(:chatroom_id => @room.id, :user_id => user_id)
  		@cru = ChatroomUser.create!(user_id: friend_id, chatroom_id: @room.id)
  		return @room
  	end
  end

  # def self.has_user?(user)
  # 	not joins(:chatroom_users).where("chatroom_users.user_id = ?", user).empty?
  # end

  def self.find_room(user_id, friend_id)
  	r = select('id').joins(:chatroom_users).where("chatroom_users.user_id in ( ?, ? )", user_id, friend_id).group('id').having("count(1) > ?", 1).first
  	if r then return find(r.id) end
  end

  def create_message(user_id, message_content)
  	Message.create(user_id: user_id, content: message_content, chatroom_id: self.id)
    
  end

end
