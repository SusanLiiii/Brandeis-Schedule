class ParticipantSessionsController < ApplicationController
  def new
  end

  def create
    participant = Participant.find_by(email: params[:session][:email].downcase)

    if participant && participant.authenticate(params[:session][:password])
      reset_session
      participant_log_in participant
      redirect_to participant
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
