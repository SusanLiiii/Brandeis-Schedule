class ApplicationController < ActionController::Base
  include ParticipantSessionsHelper
  include OrganizerSessionsHelper
  include ApplicationHelper
  #getUpdatedCalendar
end
