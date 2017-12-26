require 'epitech_api/DataTypes/basic_student'

module EpitechApi
  class Student < BasicStudent

    attr_accessor :closed, :time_active, :time_needed

    def initialize(login, first_name, last_name, picture, location, time_active, time_needed, closed)
      @login = login
      @first_name = first_name
      @last_name = last_name
      @picture = picture
      @location = location
      @time_active = time_active
      @time_needed = time_needed
      @closed = closed
    end

  end
end