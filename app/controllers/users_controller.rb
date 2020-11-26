class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_address

  def show
    @nickname = current_user.nickname
    @items = current_user.items
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_address
    @address = current_user.address
  end
end
