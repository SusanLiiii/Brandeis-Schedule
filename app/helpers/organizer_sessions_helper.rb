module OrganizerSessionsHelper
  def log_in(organizer)
    session[:organizer_id] = organizer.id
  end
end
