require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # let(:user){name="User" ; User.create!(:id => 0, :name => name, :email => "#{name}@email", :password => name)}
  # let(:friend){name="Friend" ; User.create!(:id => 1, :name => name, :email => "#{name}@email", :password => name)}
  # let(:stranger){name="Stranger" ; User.create!(:id => 2, :name => name, :email => "#{name}@email", :password => name)}
  # let(:room1){ Chatroom.create!(:id => 1, :name => 'first chat room')  	}
  # let(:chatroom_user1){ChatroomUser.create!(:chatroom_id => 1, :user_id => 0)}
  # let(:chatroom_user2){ChatroomUser.create!(:chatroom_id => 1, :user_id => 1)}

  # it 'test the let id' do
  # 	expect([[user.id, friend.id, stranger.id]])
  # 	.to eql([[0,1,2]])
  # end
  before do
  	name="User" ;  	@user = User.create!(:id => 0, :name => name, :email => "#{name}@email", :password => name)
  	name="Friend" ;   	@friend=User.create!(:id => 1, :name => name, :email => "#{name}@email", :password => name)
  	name="Stranger" ;   	@stranger=User.create!(:id => 2, :name => name, :email => "#{name}@email", :password => name)

  	@room1 = Chatroom.create!(:id => 1, :name => 'first chat room')
  	@chatroom_user1=ChatroomUser.create!(:chatroom_id => 1, :user_id => 0)
  	@chatroom_user2=ChatroomUser.create!(:chatroom_id => 1, :user_id => 1)
  end

  it 'test if all objects are valid' do  	  	
  	expect([@chatroom_user1.valid?, @chatroom_user2.valid?, @room1.valid?]).to eq([true, true, true])
  end

  it "can find room" do
  	cr = Chatroom.find_room(@user.id, @friend.id)
  	expect(cr.class.name).to eq('Chatroom')
  end 	

  it "can NOT find room" do
  	cr = Chatroom.find_room(@user.id, @stranger.id)
  	expect(cr).to be_nil
  end 	

  it "can find or create room" do
  	cr = Chatroom.find_or_create_room(@user.id, @friend.id)
  	expect(cr.class.name).to eq('Chatroom')
  end

  it "can create message" do
    cr = Chatroom.find_or_create_room(@user.id, @friend.id)
    m = cr.create_message(@user.id, 'I am a new message')
    expect(m.valid?).to be true
  end
end
