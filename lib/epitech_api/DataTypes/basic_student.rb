module EpitechApi
  class BasicStudent

    attr_accessor :login, :first_name, :last_name, :location, :picture

    def initialize(login, first_name, last_name, picture, location)
      @login = login
      @first_name = first_name
      @last_name = last_name
      @picture = picture
      @location = location
    end

  end
end