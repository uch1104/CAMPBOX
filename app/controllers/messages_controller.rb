class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      if @message.save
        @another_member = Entry.where(room_id: @message.room_id).where.not(user_id: current_user.id)
        @visited = @another_member.find_by(room_id: @message.room_id)
        notification = current_user.active_notifications.new(
          room_id: @message.room_id,
          message_id: @message.id,
          visited_id: @visited.user_id,
          visitor_id: current_user.id,
          action: 'dm'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    else
      flash[:alert] = 'メッセージ送信に失敗しました。'
    end
    redirect_to room_path(@message.room_id)
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to room_path(@message.room_id)
  end

  private 
  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end

end
