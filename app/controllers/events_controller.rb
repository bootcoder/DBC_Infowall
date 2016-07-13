class EventsController < ApplicationController

  include SessionsHelper

  EVENT_NOT_FOUND_ERROR = { :errors => "ERROR: Event not found." }
  EVENT_UPDATE_ERROR = { :errors => "ERROR: Event update failed." }

  def cards
    # It might be worth moving this into a scope in the model to make it a little
    # easier to read. If I were coming into this, something like
    # Event.most_recent (or something?) is easier to understand what's going on
    # quickly.
    @events = Event.order(schedule: :desc).last(8).reverse
    respond_to do |format|
      format.html { render :cards }
      format.json { render json: @events }
    end
  end

  def all_cards_today
    @events = Event.todays_cards
    respond_to do |format|
      format.html { render :cards }
      format.json { render json: @events }
    end
  end

  def duplicate_card
    # As with my comment below, Rails at least _used_ to render a 404
    # automatically if a RecordNotFound exception was raised. #find raises a
    # RecordNotFound exception if something isn't found.
    # I have more opinions about using #find_by_id.
    @event = Event.find_by_id(params[:format])
    render :edit
  end


  def index
    @events = Event.order(schedule: :desc).reverse
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @events }
    end
  end


  def new
    @event = Event.new
    respond_to do |format|
      format.html { render :new }
      format.json { render json: @event }
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    if @event
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @event }
      end
    else
      respond_to do |format|
        format.html { render :show }
        # Why not just respond with a 404? In fact, if you use #find instead of
        # #find_by_id, I believe Rails may automatically respond with a 404,
        # making this entire block unnecessary :)
        # Even if that's not the case, I like just sending back a status code.
        # They're trying to find an event. Status 404 says exactly what you want
        # without having to parse a response.
        format.json { render json: EVENT_NOT_FOUND_ERROR }
      end
    end
  end

  def edit
    @event = Event.find_by_id(params[:id])
    if @event
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @event }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: EVENT_NOT_FOUND_ERROR }
      end
    end
  end

  def create
    @event = Event.new(event_params)
    # The timezone is already set in application.rb, does it need to be set here
    # as well? Genuinely wondering, there might be some weird workaround going
    # on here. If there is, I'd probably put a comment about it just so I
    # remember what it is in the future.
    Time.zone = "Pacific Time (US & Canada)"
    @event.schedule = Time.zone.parse(event_params['schedule'])
    if @event.save
      respond_to do |format|
        format.html { redirect_to events_path }
        format.json { render json: @event }
      end
    else
      respond_to do |format|
        format.html { render :new  }
        format.json { render json: @events.errors }
      end
    end
  end

  def update
    return self.create if params[:commit] == 'duplicate'
    @event = Event.find_by_id(params[:id])
    if @event
      if @event.update_attributes(event_params)
        Time.zone = "Pacific Time (US & Canada)"
        @event.update_attributes(schedule: Time.zone.parse(event_params['schedule']))
        respond_to do |format|
          format.html { redirect_to events_path }
          format.json { render json: @events }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          # You might be able to use just a status here as well.
          format.json { render json: EVENT_UPDATE_ERROR }
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: EVENT_NOT_FOUND_ERROR }
      end
    end
  end

  def destroy
    @event = Event.find_by_id(params[:id])
    if @event
      @event.destroy
      @events = Event.all
      respond_to do |format|
        format.html { redirect_to events_path }
        format.json { render json: @events }
      end
    else
      respond_to do |format|
        format.html { redirect_to events_path }
        format.json { render json: EVENT_NOT_FOUND_ERROR }
      end
    end

  end

  private

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def event_params
    params.require(:event).permit(:title, :organizer, :location, :img_url, :event_url, :description, :schedule, :attending, :event_type)
  end
end

