require_relative '../DataTypes/basic_student'

module EpitechApi
  class PromoManager

    def initialize(token)
      @token = token
    end

    # @param [string] location base location for the promotion
    # @param [number] year of activity of this promotion
    # @return List of all promotions matching criteria
    def list(location, year)
      uri = URI("https://intra.epitech.eu/user/filter/promo?format=json&location=#{location}&year=#{year}&active=true")

      req = Net::HTTP::Get.new uri
      req['Cookie'] = "#{@token}"

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true

      response = http.request req
      raise InvalidRights unless response.code.to_i == 200
      response_body = JSON.parse response.body

      promos = []
      response_body.each do |p|
        promos.push Promo.new(p['promo'], p['students'].to_i, year, location)
      end
      promos
    end

    # @param [string] name Promo name
    # @param [string] location location (ex FR/LIL)
    # @param [number] year year of selected promotion
    def get(name, location, year)
      promos = list(location, year)
      promos.each do |promo|
        return promo if promo.name == name && promo.location == location && promo.year == year
      end
      raise ResourceNotFound
    end

    # @param [Promo] promo Promotion to extract students information
    # @return Array<BasicUser>
    def extract_students(promo)
      students = []
      idx = 0
      while idx < promo.size
        uri = URI("https://intra.epitech.eu/user/filter/user?format=json&location=#{promo.location}&year=#{promo.year}&active=true&promo=#{promo.name}&offset=#{idx}")

        req = Net::HTTP::Get.new uri
        req['Cookie'] = "#{@token}"

        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true

        response = http.request req

        raise InvalidRights unless response.code.to_i == 200
        response_body = JSON.parse response.body
        students.push *convert_users(response_body['items'])
        idx += response_body['items'].size
      end
      students
    end

    private

    def convert_users(users)
      students = []
      users.each do |u|
        students.push BasicStudent.new(u['login'], u['prenom'], u['nom'], u['picture'], u['location'])
      end
      students
    end
  end
end