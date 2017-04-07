class CalendarsController < ApplicationController

  def index
    @calendar = Calendar.new(Token.last)
    @calendar.import_events
    @calendar_events = Event.order(schedule: :desc).last(8).reverse
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @calendar_events }
    end
  end
end
