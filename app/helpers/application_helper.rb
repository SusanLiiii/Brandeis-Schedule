module ApplicationHelper

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

  def get_room_list
    entry = [['Select a room', '']]
    Room.all.each do |room|
      entry << ["#{room.location}: #{room.name}", room.id]
    end
    return entry
  end

  def get_organizer_list
    entry = [['Select an organizer', '']]
    Organizer.all.each do |org|
      entry << [org.name, org.id]
    end
    return entry
  end

  def get_time_list
    entry = [['Select a time', '']]
    TimeBlock.all.each do |time|
      entry << [time.start_time, time.id]
    end
    return entry
  end

  def get_date_time(event, time)
    date =  Date.new(event["date(1i)"].to_i, event["date(2i)"].to_i, event["date(3i)"].to_i)
    start_time = Time.new(date.year, date.month, date.day, time["start_time(4i)"].to_i, time["start_time(5i)"].to_i)
    end_time = Time.new(date.year, date.month, date.day, time["end_time(4i)"].to_i, time["end_time(5i)"].to_i)
    return date, start_time, end_time
  end

end
