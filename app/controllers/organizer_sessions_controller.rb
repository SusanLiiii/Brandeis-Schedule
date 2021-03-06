class OrganizerSessionsController < ApplicationController
  def new
  end

  def create
    organizer = Organizer.find_by(name: params[:session][:name])

    respond_to do |format|
      if organizer && organizer.authenticate(params[:session][:password])
        reset_session
        organizer_log_in organizer
        format.html { redirect_to organizer, notice: 'Organizer was successfully logged in.' }
        format.json { render :show, status: :created, location: organizer }
      else
        format.html { render :new }
        format.json { render json: organizer.errors, status: :unprocessable_entity }
      end
    end
  end
end
