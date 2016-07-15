class FriendshipsController < ApplicationController
	def new
		@current_user = current_user
		@users = User.all.limit(10).order('email desc')

		respond_to do |format|
			format.html {}
			format.js {}
		end
	end

	def create
		@current_user = current_user
		fs = Friendship.new(user_id: @current_user.id, friend_id: params[:id], authorized: true)
		byebug
		if fs.valid?
			flash[:notice] = "Congratualtion #{@current_user.email}, user \"#{params[:name]}\" is now your friend!"
			fs.save
			redirect_to new_friendship_path
		else
			raise "create friendship errors"
		end			
	end

end
