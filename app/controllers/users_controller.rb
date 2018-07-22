class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @new_message = current_user.messages.build
  end
end
