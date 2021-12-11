class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if !Participant.exists?(:email => @participant.email)
        if @participant.save
          reset_session
          participant_log_in @participant
          format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
          format.json { render :show, status: :created, location: @participant }
        end
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_to_schedule
    @participant = Participant.find(session[:participant_id])
    if !@participant.events.include?(Event.find(params[:event_id]))
      EventNotificationMailer.with(user: @participant, event: Event.find(params[:event_id])).event_subscribe_email.deliver_later
      ParticipantSchedule.create(participant_id: @participant.id, event_id: params[:event_id])
      flash[:success] = "You have successfully enrolled in this course."
      redirect_to @participant
    end
  end

  def remove_from_schedule
    @participant = Participant.find(session[:participant_id])
    if @participant.events.include?(Event.find(params[:event_id]))
      ParticipantSchedule.where(participant_id: @participant.id, event_id: params[:event_id]).destroy_all
      flash[:success] = "You have successfully unenrolled from this course."
      redirect_to @participant
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:name, :email, :password, :password_confirmation)
    end
end
