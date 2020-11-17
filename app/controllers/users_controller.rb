class UsersController < ApplicationController

  def show
    @nickname = current_user.nickname
    @items = current_user.items
  end

  def edit
  end

  def update
    if current_user.update(user_params) 
      redirect_to user_path(current_user.id) 
    else
      redirect_to "edit" 
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
