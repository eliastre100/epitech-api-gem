require 'net/https'
require 'cgi/cookie'
require_relative '../Exceptions/invalid_credentials'
require_relative '../user'

module EpitechApi
  class OfficeProvider

    def self.login(code)
      uri = URI("https://intra.epitech.eu/auth/office365?code=#{code}&state=%2f")
      response = Net::HTTP.get_response(uri)
      raise InvalidCredentials unless response.code.to_i == 302

      cookie = CGI::Cookie::parse(response['Set-Cookie'])
      token = cookie['user']
      User.new token
    end
  end
end