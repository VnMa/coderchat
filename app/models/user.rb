class User < ApplicationRecord	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	has_secure_password

	has_many :chatroom_users
	has_many :chatrooms, :through => :chatroom_users

	has_many :messages, inverse_of: :user

	has_many :friendships
	has_many :friends, :through => :friendships
	
	# # an example of how to get only the authorized friends
	# has_many :authorized_friends, :through => :friendships, :source => :friend, :conditions => [ "authorized = ?", true ]
	# has_many :authorized_friends, -> (object) { where("authorized = ?", true) }, :through => :friendships

	# an example of how to get only the unauthorized friends
  # has_many :unauthorized_friends, -> { where(friendship: {authorized: false	}) }, :through => :friendships, :source => :friend

  # def find_or_create_chat_room(friend)
  #   @chatroom = chatroom_users.find_or_create_chat_room(id, friend.id)
  # end

  def latest_sent_messages
    messages.order(Message.arel_table['created_at'].desc)
  end

  def messages_sent_to_self
    chatrooms.map{|m| m.messages_sent_to(self.id)}
  end

  def send_message_to(message_content, friend_id)
    @chatroom = Chatroom.find_or_create_room(self.id,friend_id)
    @chatroom.create_message(self.id, message_content)
  end

  # def self_messages
  #   messages.where(user_id: self.id)
  # end

  def is_friend(user_id)
    return self.friends.exists?(user_id)
  end

  def authorized_friends
    self.friends.where('authorized is true')
  end

  def unauthorized_friends
    self.friends.where('authorized is false')
  end

  def friend_ids
    friends.map{|x| x.id}
  end

  def friend_and_self_ids
    friend_ids.append(id)
  end

  def self.stranger_list(user)
    return User.where("id NOT IN (?)", user.friend_and_self_ids)
  end
end
