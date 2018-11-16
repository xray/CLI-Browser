require 'uri'

class DuckDuckGoSearchProvider
  attr_reader :http, :parser

  def initialize(http, parser)
    @http = http
    @parser = parser
  end

  def results(term)
    body = http.get(url(term))
    parser.parse(body)
  end

  def url(term)
    query_encoded = URI.encode_www_form([['q', term]])
    URI("https://duckduckgo.com/html/?#{query_encoded}")
  end
end
