class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.order('created_at DESC')
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @address = current_user.address
  end
end
