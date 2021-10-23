module ParticipantSessionsHelper
  def log_in(participant)
    session[:participant_id] = participant.id
    session
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
  
end
