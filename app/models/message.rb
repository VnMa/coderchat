# require 'carrierwave/orm/activerecord'

class Message < ApplicationRecord
	belongs_to :user, inverse_of: :messages
	belongs_to :chatroom, inverse_of: :messages
	# mount_uploader :img_url, AvatarUploader


	def full_content
		return "#{user_id}: #{content}"
	end

	def is_sent_to(somebody)
		chatroom.get_recipients(user.id).where('user_id = ?', somebody).exists?
	end

	def sender_name
		user.name
	end

	def read_it
		self.update(status: "Read", updated_at: Time.now)
	end

	def unread
		self.update(status: "Unread")
	end

	def is_read?
		return  ( not status.nil? and (status != "Unread"))
	end

	# def format(s)
	# 	if status == "Unread"
	# 		return "<strong>#{s}</strong>"
	# 	else
	# 		return s
	# 	end
	# end
end
