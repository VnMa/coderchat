class Message < ApplicationRecord
	belongs_to :user
	belongs_to :chatroom

	def full_content
		return "#{user_id}: #{content}"
	end

	# def format(s)
	# 	if status == "Unread"
	# 		return "<strong>#{s}</strong>"
	# 	else
	# 		return s
	# 	end
	# end
end
