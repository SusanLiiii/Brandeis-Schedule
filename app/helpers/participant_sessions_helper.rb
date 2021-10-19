module ParticipantSessionsHelper
  def log_in(participant)
    session[:participant_id] = participant.id
  end
end
