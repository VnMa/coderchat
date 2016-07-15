require 'rails_helper'

RSpec.describe Message, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
  	name="User" ;  	@user = User.create!(:id => 0, :name => name, :email => "#{name}@email", :password => name)
  	name="Friend" ;   	@friend=User.create!(:id => 1, :name => name, :email => "#{name}@email", :password => name)
  	name="Stranger" ;   	@stranger=User.create!(:id => 2, :name => name, :email => "#{name}@email", :password => name)

  	@room1 = Chatroom.create!(:id => 1, :name => 'first chat room')
  	@chatroom_user1=ChatroomUser.create!(:chatroom_id => 1, :user_id => 0)
  	@chatroom_user2=ChatroomUser.create!(:chatroom_id => 1, :user_id => 1)
  end

  it "can send message " do
  	message_content = "Hello my friend"
  	Message.create(user_id: @user.id, content: message_content, chatroom_id: @room1.id)

  	expect(Message.count).to be > 0
  end

end
