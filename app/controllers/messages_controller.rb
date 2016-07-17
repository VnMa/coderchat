class MessagesController < ApplicationController
	def index
		unless logged_in?
			redirect_to login_path, notice: "Please login first. "
		else
			@user = current_user
			# @chatrooms = @user.chatrooms
			# @curr_chatroom = @chatrooms.first
			# @messages = @curr_chatroom.messages.order(" created_at DESC")
			@messages = @user.messages.order(" created_at DESC")
			@unread_messages = @user.messages_sent_to_self
		end
	end

	def new
		@current_user = current_user
	end

	def create
		@current_user = current_user
		if params[:friend]
			@friend_list_id = params[:friend]
			@message_content = params[:message_content]
			@current_user.send_message_to(@message_content, @friend_list_id)
			flash[:notice] = "Hi #{@current_user.name}, your message is sent to #{@current_user.friend_names(@friend_list_id)}"
			render 'new'
		else
			raise 'Friend id not found. Please recheck'
			render :back
		end
	end

	def show
		@message = Message.find(params[:id])
		@message.read_it


		@user = current_user
		@unread_messages = @user.messages_sent_to_self
		respond_to :html, :js
	end


	def messages_sent
		unless logged_in?
			redirect_to login_path, notice: "Please login first. "
		end

		@current_user = current_user
		# @chatrooms = @current_user.chatrooms
		# @curr_chatroom = @chatrooms.first

		@messages = @current_user.latest_sent_messages
	end



end
