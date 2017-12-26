require 'epitech_api/DataTypes/promo'
require 'epitech_api/Managers/promo_manager'


module EpitechApi

  class Gatherer

    attr_accessor :promo_manager

    def initialize(token)
      @token = token
      @promo_manager = PromoManager.new @token
    end

    # @param [string] name Name of the promotion
    # @return List of all students in this promotion
    def promo_students(name, location, year) # TODO
      uri = URI("https://intra.epitech.eu/user/filter/user?format=json&location=#{location}&year=#{year}&active=true&promo=#{name}&offset=")

      req = Net::HTTP::Get.new uri
      req['Cookie'] = "#{@token}"

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true

      response = http.request req

      raise InvalidRights unless response.code.to_i == 200
      JSON.parse response.body
    end

    def user(email) # TODO
      uri = URI("https://intra.epitech.eu/#{email}?format=json")

      req = Net::HTTP::Get.new uri
      req['Cookie'] = "#{@token}"

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true

      response = http.request req

      raise InvalidRights unless response.code.to_i == 200
      JSON.parse response.body
    end

  end
end