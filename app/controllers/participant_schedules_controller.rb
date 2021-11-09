class ParticipantSchedulesController < ApplicationController
  before_action :set_participant_schedule, only: [:show, :edit, :update, :destroy]

  # GET /participant_schedules
  # GET /participant_schedules.json
  def index
    @participant_schedules = ParticipantSchedule.all
  end

  # GET /participant_schedules/1
  # GET /participant_schedules/1.json
  def show
  end

  # GET /participant_schedules/new
  def new
    @participant_schedule = ParticipantSchedule.new
  end

  # GET /participant_schedules/1/edit
  def edit
  end

  # POST /participant_schedules
  # POST /participant_schedules.json
  def create
    @participant_schedule = ParticipantSchedule.new(participant_schedule_params)

    respond_to do |format|
      if @participant_schedule.save
        format.html { redirect_to @participant_schedule, notice: 'Participant schedule was successfully created.' }
        format.json { render :show, status: :created, location: @participant_schedule }
      else
        format.html { render :new }
        format.json { render json: @participant_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participant_schedules/1
  # PATCH/PUT /participant_schedules/1.json
  def update
    respond_to do |format|
      if @participant_schedule.update(participant_schedule_params)
        format.html { redirect_to @participant_schedule, notice: 'Participant schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant_schedule }
      else
        format.html { render :edit }
        format.json { render json: @participant_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participant_schedules/1
  # DELETE /participant_schedules/1.json
  def destroy
    @participant_schedule.destroy
    respond_to do |format|
      format.html { redirect_to participant_schedules_url, notice: 'Participant schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant_schedule
      @participant_schedule = ParticipantSchedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participant_schedule_params
      params.require(:participant_schedule).permit(:participant_id, :event_id)
    end
end
