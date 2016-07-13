# Nice, man!
# Something to ponder for the future: what if the connection to Deputy was
# transparent?
# This could just be a Mentor collection and you could use Mentor.all or
# something instead. If it needs to, the class can call out to Deputy (or any
# service) to retrieve information and the consuming code doesn't even have to
# care about where it's getting the information.
class DeputyAdapter

  include HTTParty

  base_uri 'sfmentors.na.deputy.com/api/v1'

  def initialize
    @token = ENV["DEPUTY_TOKEN"]
  end

  def get_endpoint(endpoint)
    self.class.get(endpoint, headers: {"Authorization" => "OAuth #{@token}"})
  end

  def get_current_mentors
    self.class.get("/my/location/1", headers: {"Authorization" => "OAuth #{@token}"})
  end

end


