class OrganizerSessionsController < ApplicationController
  def new
  end

  def create
    organizer = Organizer.find_by(name: params[:session][:name])
    if organizer && organizer.authenticate(params[:session][:password])
      reset_session
      log_in organizer
      redirect_to organizer
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
