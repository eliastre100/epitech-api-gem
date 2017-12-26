require 'epitech_api/DataTypes/student'

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
      Student.new body['login'], body['firstname'], body['lastname'], body['picture'], body['location'], body['nsstat']['active'], body['nsstat']['nslog_norm'], body['close']
    end

  end
end