class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def search
    @rooms = Room.all
  end

  def do_search
    @rooms = Room.all
    if params[:location] != 'Select a location'
      @rooms = @rooms.where(location: params[:location])
    end
    @rooms = @rooms.where("name LIKE ?", "%#{params[:name]}%")
    render "search"
  end

  def search_available
    @rooms = Room.all
  end

  def do_search_available
    time_list = get_date_time(params[:event_date], params[:time])
    @rooms = Calendar.new(EventSchedule.all).find_available_rooms(time_list[0], time_list[1], time_list[2])
    render "search_available"
  end

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :location, :capacity)
    end
end
