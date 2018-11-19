require 'net/http'

class HTTPClient
  def get(uri)
    Net::HTTP.get(uri)
  end
end
