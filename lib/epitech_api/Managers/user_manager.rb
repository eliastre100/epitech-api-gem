require 'net/http'
require_relative '../DataTypes/student'

module EpitechApi
  class UserManager

    def initialize(token)
      @token = token
    end

    def get(login)
      uri = URI("https://intra.epitech.eu/user/#{login}/?format=json")

      req = Net::HTTP::Get.new uri
      req['Cookie'] = "#{@token}"

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true

      response = http.request req

      raise InvalidRights unless response.code.to_i == 200
      body = JSON.parse response.body
      Student.new(login: body['login'],
                  first_name: body['firstname'],
                  last_name: body['lastname'],
                  picture: body['picture'],
                  location: body['location'],
                  time_active: body.fetch('nsstat', {})['active'],
                  time_needed: body.fetch('nsstat', {})['nslog_norm'],
                  closed: body['close'],
                  gpa: body.fetch('gpa', []).fetch(0, {})['gpa'])
    end

  end
end