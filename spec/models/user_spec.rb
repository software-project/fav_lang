require 'spec_helper'

describe User do
  subject{ FactoryGirl.build :user }

  it { should respond_to :name }

  describe "User" do
    context "should be valid" do
      it "validates name" do
        subject.valid?.should be_truthy
      end

      it "validates name" do
        subject.name = nil
        subject.valid?.should_not be_truthy
      end
    end

    context "should return user's favourite language" do
      before :each do
        a = double 'repos', :list => [{'language' => 'C#'},{'language' => 'Ruby'},{'language' => 'Ruby'}]
        Github.stub(:repos).and_return(a)
      end

      it "gets language from GitHub" do
        subject.get_favourite_lang
        subject.favourite_lang.should eq 'Ruby'
      end
    end
  end
end