require 'json'
require_relative 'Exceptions/invalid_rights'
require_relative 'gatherer'

class User

  def initialize(token)
    @token = token
  end

  def gatherer
    Gatherer.new @token
  end

  def info
    uri = URI('https://intra.epitech.eu/user/?format=json')

    req = Net::HTTP::Get.new uri
    req['Cookie'] = "#{@token}"

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true

    response = http.request req

    raise InvalidRights unless response.code.to_i == 200
    JSON.parse response.body
  end
end