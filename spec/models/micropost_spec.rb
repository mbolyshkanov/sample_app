require 'spec_helper'

describe Micropost do

	let(:user) { FactoryGirl.create(:user) }
	before do
		@micropost = user.microposts.build(content: "whatever!")
	end

	subject { @micropost }

	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }

	its(:user) { should == user}

	it { should be_valid }

	describe "accessible attributes" do
		it "should not allow acess to user_id" do
			expect do
				Micropost.new(user_id: user.id)
			end.should raise_error(Active::MassAssignmentSecurity::Error)
		end
	end
	
	describe "when user_id is not present" do
		before { @miropost.user_id = nil }
		it { should_not be_valid }
	end

	describe "with blank content" do
		before { @micropost.content = " " }
		it { should_not be_valid }
	end

	describe "with content that is too long" do
		before { @micropost.content = "a" * 142 }
		it { should_not be_valid }
	end
end