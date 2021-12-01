module ApplicationHelper
  include TimeBlocksHelper

  def is_organizer?
    session[:isOrganizer]
  end

  def current_user
    if session[:organizer_id]
      @current_user ||= Organizer.find_by(id: session[:organizer_id])
    elsif session[:participant_id]
      @current_user ||= Participant.find_by(id: session[:participant_id])      
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
    @current_user = nil
  end
end
