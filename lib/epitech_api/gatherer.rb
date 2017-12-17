class Gatherer

  def initialize(token)
    @token = token
  end

  def promos(location, year)
    uri = URI("https://intra.epitech.eu/user/filter/promo?format=json&location=#{location}&year=#{year}&active=true")
    puts uri

    req = Net::HTTP::Get.new uri
    req['Cookie'] = "#{@token}"

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true

    response = http.request req

    puts response
    raise InvalidRights unless response.code.to_i == 200
    JSON.parse response.body
  end
end