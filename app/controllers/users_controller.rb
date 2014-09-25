class UsersController < ApplicationController
  def index
    @user = User.new
    @user.name = params.try(:[], 'user').try(:[], 'name')
    if @user.valid?
      begin
        @user.get_favourite_lang
      rescue Exception => e
        flash[:error] = e.message
        render "new"
      end
    else
      render "new"
    end
  end

  def new
    @user = User.new
  end
end
