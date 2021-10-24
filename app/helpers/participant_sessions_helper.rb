module ParticipantSessionsHelper
  def participant_log_in(participant)
    session[:participant_id] = participant.id
    session[:isOrganizer] = false
  end
end
