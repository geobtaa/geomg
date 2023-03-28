# frozen_string_literal: true

# NotificationsController
class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[update destroy]

  def index
    @pagy, @notifications = pagy(current_user.notifications.order(created_at: :desc), items: 20)
  end

  def update
    case params[:read]
    when "0"
      @notification.update(read_at: nil)
      @toast = "Notification marked unread."
    when "1"
      @notification.update(read_at: Time.zone.now)
      @toast = "Notification marked read."
    end

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.js
    end
  end

  def destroy
    @notification.file.purge
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: "Notification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def batch
    return unless params[:read] == "all"

    current_user.notifications.mark_as_read!
    flash[:success] = "All notifications marked as read."
    redirect_to notifications_url
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
