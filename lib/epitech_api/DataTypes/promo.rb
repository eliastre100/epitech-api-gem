module EpitechApi
  class Promo

    attr_accessor :name, :size, :year, :location

    def initialize(name, size, year, location)
      @name = name
      @size = size
      @year = year
      @location = location
    end

  end
end