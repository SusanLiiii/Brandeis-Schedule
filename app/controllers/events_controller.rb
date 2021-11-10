class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @room_id = params[:room_id]
    @event_date = params[:event_date]
    @start_time = params[:start_time]
    @end_time = params[:end_time]
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @name = params[:event][:name]
    @description = params[:event][:description]
    @room = params[:event][:room]
    @organizer = session[:organizer_id]
    @event_date = params[:event][:date].to_date
    @start_time = params[:event][:start_time].to_time
    @end_time = params[:event][:end_time].to_time
    @event_schedule = []
      if @end_time > @start_time && Calendar.new(EventSchedule.all).check_room_availability(@room, @event_date, @start_time, @end_time)
        @event = Event.new(name: @name, description: @description, room_id: @room, organizer_id:@organizer)
        if @event.save
          (Calendar.new(EventSchedule.all).find_start_time(@start_time).id...Calendar.new(EventSchedule.all).find_end_time(@end_time).id+1).each do |time|
            @event_schedule << EventSchedule.new(event_id: @event.id, date:@event_date, room_id: @room, time_block_id: time)
            puts @event_schedule
          end
          @success = true
          @event_schedule.each do |event_schedule|
            @success = @success && event_schedule.save
          end
          if @success
            redirect_to @event
          end
        end
      else
        if !@event.nil?
          @event.destroy
        end
        @event_schedule.each do |event_schedule|
          event_schedule.destroy
        end
        redirect_to new_event_path(room_id: @room, event_date: @event_date, start_time: @start_time, end_time: @end_time)
      end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @events = Event.all
  end

  def do_search
    @events = Event.all
      if !params[:room].blank?
        @events = @events.where(room_id: params[:room])
      end
      if !params[:org].blank?
        @events = @events.where(organizer_id: params[:org])
      end
      @events = @events.where("name LIKE ?", "%#{params[:name]}%")
      render "search"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :organizer_id, :room_id, :event_date, :start_time, :end_time)
    end
end
