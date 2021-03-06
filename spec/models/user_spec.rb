require 'rails_helper'

RSpec.describe User, type: :model do
	# pending "add some examples to (or delete) #{__FILE__}"
	before do
		name="User" ;  	@user = User.create!(:id => 0, :name => name, :email => "#{name}@email", :password => name)
		name="Friend" ;   	@friend=User.create!(:id => 1, :name => name, :email => "#{name}@email", :password => name)
		name="Stranger" ;   	@stranger=User.create!(:id => 2, :name => name, :email => "#{name}@email", :password => name)
		name="Gerard" ;   	@gerard=User.create!(:id => 3, :name => name, :email => "#{name}@email", :password => name)


		@room1 = Chatroom.create!(:id => 1, :name => 'first chat room')
		@chatroom_user1=ChatroomUser.create!(:chatroom_id => 1, :user_id => 0)
		@chatroom_user2=ChatroomUser.create!(:chatroom_id => 1, :user_id => 1)
	end


	it "count user correctly" do 
		count = User.count
		expect(count).to be > 0
	end

	it "count total messages BEFORE sending" do
		expect(Message.count).to eq(0)
	end

	it "test the let" do
		emails = ['User@email','Friend@email']
		expect([@user.email,@friend.email]).to eq(emails)
	end

	it "can find room" do
		cr = Chatroom.find_or_create_room(@user.id, @friend.id)
		expect(cr.class.name).to eq('Chatroom')
	end

	it "can send message multiple friends" do
		friendA, friendB = "1", "3"
		@user.send_message_to("Hello friend, I'm User ", [friendA, friendB ]);
		
		c1 = @user.messages_sent_to_self.count
		c2 = User.find(friendA).messages_sent_to_self.count
		c3 = User.find(friendB).messages_sent_to_self.count
		expect([c1,c2,c3]).to eq [1,1,1]
	end
end
