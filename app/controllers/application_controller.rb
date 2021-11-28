class ApplicationController < ActionController::Base
  include ParticipantSessionsHelper
  include OrganizerSessionsHelper
  include ApplicationHelper
  def destroy_session
    log_out
    redirect_to root_url
  end
end
