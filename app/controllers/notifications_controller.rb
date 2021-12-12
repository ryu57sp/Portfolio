class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.includes(:visitor).includes(:visited).includes(:dive).page(params[:page]).per(20)
    @notifications.includes(:visitor).includes(:visited).where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
