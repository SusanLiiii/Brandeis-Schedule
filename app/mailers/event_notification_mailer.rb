class EventNotificationMailer < ApplicationMailer
  def event_subscribe_email
    @event = params[:event]
    @user = params[:user]
    mail(to: @user.email, subject: "Successful subscription on event: #{@event.name}")
  end

  def event_edit_email
    @event = params[:event]
    mail(to: @event.participants.pluck(:email), subject: "Change for event: #{@event.name}")
  end

  def event_cancel_email
    @event = params[:event]
    mail(to: @event.participants.pluck(:email), subject: "Cancel on event: #{@event.name}")
  end
end