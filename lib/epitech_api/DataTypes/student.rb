require_relative 'basic_student'

module EpitechApi
  class Student < BasicStudent

    attr_accessor :login, :first_name, :last_name, :picture, :location, :closed, :time_active, :time_needed, :gpa,

    def initialize(infos)
      @login, @first_name, @last_name, @picture, @location, @time_active, @time_needed, @closed, @gpa =
          infos.values_at(:login, :first_name, :last_name, :picture, :location, :time_active, :time_needed, :closed, :gpa)
    end

  end
end