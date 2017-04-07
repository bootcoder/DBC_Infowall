require 'google_calendar'

class Calendar

  attr_reader :cal
  def initialize(token)
    @token = token
    calendar_login
  end

  def calendar_login
    @cal = Google::Calendar.new(:client_id => ENV['CLIENT_ID'],
                               :client_secret => ENV['CLIENT_SECRET'],
                               :calendar      => ENV['INFOWALL_CALENDAR_ID'],
                               :redirect_url  => "https://dbc-infowall.herokuapp.com/auth/google_oath2/@callback"
                               )
    @cal.login_with_refresh_token(@token.fresh_token)
    @cal
  end

  def event
  end

  def find_event
    @event = @cal.find_or_create_event_by_id(@event.id) do |e|
      e.title = 'An Updated Cool Event'
      e.start_time = Time.now + (60 * 60 * 2) # seconds * min * hours
    end
    @event
  end

  def all_events
    @cal.find_future_events
  end

  def sanitize_img_url(staff_name, event)
    p staff_name
    p event.raw["creator"]["email"]
    return "jenny.jpg" if event.raw["creator"]["email"] == "sally.attaalla@devbootcamp.com"
    return "jenny.jpg" if event.raw["creator"]["email"] == "jenny@devbootcamp.com"
    return "dbc.jpg" if staff_name == nil || staff_name == ""
    sanitize_name(staff_name, event).split(" ")[0].downcase.concat(".jpg")
  end

  def sanitize_name(name, event)
    # byebug
    return "" if name == "Jenny" || name == "Jenny Engard"
    return "" if event.raw["creator"]["email"] == "sally.attaalla@devbootcamp.com"
    return "" if event.raw["creator"]["email"] == "jenny@devbootcamp.com"
    return "Katy" if event.title.downcase.include?('yoga')
    name
  end

  def sanitize_location_length(location)
    return "DBC" if location == nil
    return location if location.length < 18
    location.match(/[^-]+$/).to_s
  end

  def sanitize_description_length(description)
    return description if description.length < 200
    "DEPSCRIPTION LENGTH TOO LONG (Must be under 200 characters)"
  end

  def import_events
    all_events.each_with_index do |event, index|
      next if index > 15
      event_datetime = DateTime.parse(event.raw['start']['dateTime'])
      if event_datetime > Date.current
        @event = Event.find_or_create_by(calendar_id: event.id)
        @event.update(
          title: event.title,
          description: event.description,
          organizer: sanitize_name(event.creator_name, event),
          location: sanitize_location_length(event.location),
          img_url: sanitize_img_url(event.creator_name, event),
          event_type: "calendar",
          attending: 0,
          schedule: event_datetime
          )
        if @event.errors.full_messages.length > 1
          ap @event
          ap @event.errors
        end
        @event
      end
    end
  end

end
