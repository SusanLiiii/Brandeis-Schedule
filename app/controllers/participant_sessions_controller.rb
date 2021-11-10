class ParticipantSessionsController < ApplicationController
  def new
  end

  def create
    participant = Participant.find_by(email: params[:session][:email].downcase)

    respond_to do |format|
      if participant && participant.authenticate(params[:session][:password])
      reset_session
      participant_log_in participant
      format.html { redirect_to participant, notice: 'Participant was successfully logged in.' }
      format.json { render :show, status: :created, location: participant }
      else
        format.html { render :new }
        format.json { render json: participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
