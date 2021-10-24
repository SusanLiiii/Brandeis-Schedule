module OrganizerSessionsHelper
  def organizer_log_in(organizer)
    session[:organizer_id] = organizer.id
    session[:isOrganizer] = true
  end
end
