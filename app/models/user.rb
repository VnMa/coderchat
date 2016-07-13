class User < ApplicationRecord	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	has_secure_password

	has_many :friend_lists
	has_many :friends, :class_name => "User", :foreign_key => "friend_id"
	
	has_many :authorized_friends, :through => :friendlists, :source => :friend, :conditions => [ "authorized = ?", true ]
  
  # an example of how to get only the unauthorized friends
  has_many :unauthorized_friends, :through => :friendships, :source => :friend, :conditions => [ "authorized = ?", false ]
	# def make_friend(f)
	# 	l = FriendList.new user_id: self.id, friend_id: f.id, status: 'active'
	# 	l.save!	
	# end
end
