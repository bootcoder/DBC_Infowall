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
