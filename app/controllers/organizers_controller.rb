class OrganizersController < ApplicationController
  before_action :set_organizer, only: [:show, :edit, :update, :destroy]

  # GET /organizers
  # GET /organizers.json
  def index
    @organizers = Organizer.all
  end

  # GET /organizers/1
  # GET /organizers/1.json
  def show
  end

  # GET /organizers/new
  def new
    @organizer = Organizer.new
  end

  # POST /organizers
  # POST /organizers.json
  def create
    @organizer = Organizer.new(organizer_params)

    respond_to do |format|
      if !Organizer.exists?(:name => @organizer.name)
        if @organizer.save
          reset_session
          organizer_log_in @organizer
          format.html { redirect_to @organizer, notice: 'Organizer was successfully created.' }
          format.json { render :show, status: :created, location: @organizer }
        end
      else
        format.html { render :new }
        format.json { render json: @organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organizer
      @organizer = Organizer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organizer_params
      params.require(:organizer).permit(:name, :email, :password, :password_confirmation)
    end
end
