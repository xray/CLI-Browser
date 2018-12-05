require 'browser/generic_html_parser'

class WebPageProvider
  Page = Struct.new(:items)

  def initialize(http, parser = GenericHTMLParser)
    @http = http
    @parser = parser.new
  end

  def get(url)
    html = make_request(url)
    page_items = @parser.parse(html, url)
    Page.new(page_items)
  end

  private

  def make_request(request_url)
    @http.get(request_url)
  end
end