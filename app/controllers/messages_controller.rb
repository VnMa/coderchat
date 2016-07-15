class MessagesController < ApplicationController
	def index
		unless logged_in?
			redirect_to login_path, notice: "Please login first. "
		else
			@user = current_user
			@chatrooms = @user.chatrooms
			@curr_chatroom = @chatrooms.first
			@messages = @curr_chatroom.messages.order(" created_at DESC")
		end
	end

	def new
		@current_user = current_user
	end

	def create
		@current_user = current_user
		if params[:friend]
			@friend_id = params[:friend]
			@message_content = params[:message_content]
			@current_user.send_message_to(@message_content, @friend_id)
			flash[:notice] = "Hi #{@current_user.name}, your message is sent"
			render 'new'
		else
			raise 'Friend id not found. Please recheck'
			render :back
		end
	end


	def messages_sent
		unless logged_in?
			redirect_to login_path, notice: "Please login first. "
		end

		@user = current_user
		@chatrooms = @user.chatrooms
		@curr_chatroom = @chatrooms.first

		@messages = @curr_chatroom.messages.order(" created_at DESC")
	end



end
