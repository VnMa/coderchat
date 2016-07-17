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
		# fs1 = Friendship.new(user_id: @current_user.id, friend_id: params[:id], authorized: true)
		# fs2 = Friendship.new(user_id: params[:id], friend_id: @current_user.id, authorized: true)
		rs = current_user.make_friend_with(params[:id])

		if rs
			flash[:notice] = "Congratualtion #{@current_user.email}, user \"#{params[:name]}\" is now your friend!"			
			redirect_to new_friendship_path
		else
			raise "create friendship errors"
		end			
	end

end
