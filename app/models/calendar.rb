require 'google_calendar'

class Calendar
  attr_reader :cal
  def initialize(token)
    @token = token
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
    # where is @cal being initialized before it's used here? If it's defined in
    # another method that has to be # called *before* this method, that's some
    # coupling that is unfortunate and should probably be removed.
    @cal.find_future_events
  end

  # This looks fine for now! I wonder in the future if these make more sense as
  # instance methods on the Event class instead of in the calendar class. It
  # doesn't seem like you're using anything Calendar related in these methods
  # and you're sending in the event.
  def sanitize_img_url(staff_name, event)
    # This is also fine and is worth pushing to production now.
    return "sally.jpg" if event.raw["creator"]["email"] == "sally.attaalla@devbootcamp.com"
    return "dbc.jpg" if staff_name == nil || staff_name == "" # .blank?  <3
    sanatize_name(staff_name, event).split(" ")[0].downcase.concat(".jpg")

    # Something you might consider is just using *more* simple rules to get
    # what you want without having to do a special case for sally.
    # dbc.jpg is the default, so put that last. Then the rules could be:
    #   * Downcase the first name and add jpg on it. Does that file exist?
    # If that doesn't exist...
    #   * take the first word of the email address (up to the period or @) and
    #     add jpg to it. Does that file exist?
    # If neither of these things exist
    #   * return dbc.jpg
  end

  # sanitize*
  def sanatize_name(name, event)
    return "Sally" if event.raw["creator"]["email"] == "sally.attaalla@devbootcamp.com"
    return "Katy" if event.title.downcase.include?('yoga')
    name
  end

  # sanitize* here too (for consistency)
  def sanatize_location_length(location)
    return "DBC" if location == nil # I like using .nil? instead
    return location if location.length < 18
    location.match(/^[^\,-]*/).to_s
  end

  def import_events
    calendar_login
    all_events.each do |event|
      event_datetime = DateTime.parse(event.raw['start']['dateTime'])
      if event_datetime > Date.current
        @event = Event.create(
                        calendar_id: event.id,
                        title: event.title,
                        description: event.description,
                        organizer: sanatize_name(event.creator_name, event),
                        location: sanatize_location_length(event.location),
                        img_url: sanitize_img_url(event.creator_name, event),
                        event_type: "calendar",
                        attending: 0,
                        schedule: DateTime.parse(event.raw['start']['dateTime'])
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
