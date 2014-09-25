require 'spec_helper'

describe UsersController do

  describe 'GET new' do
    context 'no user' do
      before :each do
        @user = FactoryGirl.build :user
      end

      it 'should be able to enter user name' do
        get :new
        response.should be_successful
      end
    end
  end

  describe 'GET index' do
    context 'no user' do
      it 'should render new if name is blank' do
        get :index
        response.should render_template :new
      end
    end

    context 'with user' do
      before :each do
        @user = FactoryGirl.build :user
        a = double 'repos', :list => [{'language' => 'C#'},{'language' => 'Ruby'},{'language' => 'Ruby'}]
        Github.stub(:repos).and_return(a)
      end

      it 'should trigger loading favourite languages' do
        User.any_instance.should_receive :get_favourite_lang
        get :index, :user => {:name => @user.name}
        response.should be_successful
      end
    end
  end
end

