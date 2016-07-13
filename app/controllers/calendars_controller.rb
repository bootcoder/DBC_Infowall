class CalendarsController < ApplicationController

  def index

    @old_calendar_events = Event.where(event_type: "calendar")
    @old_calendar_events.destroy_all

    @calendar = Calendar.new(Token.last)
    @calendar.import_events

    # Hey, this is the thing I mentioned in the EventsController! Now it
    # *really* makes sense to move it to a scope. Think about how nice it
    # would be to just do Event.most_recent (or whatever) here.
    @calendar_events = Event.order(schedule: :desc).last(8).reverse

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @calendar_events }
    end

  end
end
